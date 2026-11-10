package com.mrkeyboard.app;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.DashPathEffect;
import android.graphics.Paint;
import android.graphics.RectF;
import android.os.Handler;
import android.os.Looper;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewParent;
import java.util.ArrayList;
import java.util.List;

/**
 * Grid of one keyboard sheet, drawn with Canvas inside the sheet editor: the keys of the rows with their real
 * proportions, the fixed "+" of each row, the locked "⌫" of the last row and the locked bottom row (badge, comma,
 * space, dot and enter). Touching a key opens the key editor, a long press starts the drag (the ghost under the
 * finger and the cyan line where the key drops), and the "+"/"⌫" of the locked row call the listener.
 *
 * Since 1.92.0 this class is Java like the rest of the sheet editor (the smali comes from build_java.sh/the
 * workflow, never hand-written). The layout of the cells did not change: same margins (8/10 dp), same gaps (4/5 dp),
 * same key height (48 dp), same bottom row weights (0.2/0.1/0.4/0.1/0.2), same limits (6 rows, 10 keys per row and 9
 * in the last one, because of the locked "⌫"). What changed is the paint: every color now comes from the settings
 * palette (mr_ui_*) instead of a fixed ARGB, so the keys are blue-leaning and the borders soft, like the screen around
 * them (the text of the empty row comes from mr_strings.xml, mr_grid_add_key).
 */
public class SheetGridView extends View {
    /** Width of each key of the locked bottom row, as a fraction of the row (badge, comma, space, dot, enter). */
    private static final float[] BOTTOM_WEIGHTS = {0.2f, 0.1f, 0.4f, 0.1f, 0.2f};

    /** What the editor does when a cell of the grid is touched. */
    public interface GridListener {
        /** The "+" of a row (or the whole empty row): add a key. */
        void onAddKeyTapped(int row);

        /** A key was dragged from (fromRow, fromKey) to (toRow, toIndex). */
        void onKeyDragged(int fromRow, int fromKey, int toRow, int toIndex);

        /** A normal key was tapped: edit it. */
        void onKeyTapped(int row, int key);

        /** A key that cannot be edited was tapped: deleteKey is true for "⌫", false for the bottom row. */
        void onLockedKeyTapped(boolean deleteKey);
    }

    private final Resources mRes;
    private final float mDensity;
    private final int mTouchSlop;
    private final Handler mHandler;
    private final Runnable mLongPressRunnable;

    private final ArrayList<CellHit> mCells = new ArrayList<CellHit>(72);
    private final ArrayList<CellHit> mRowHitsScratch = new ArrayList<CellHit>(12);
    private boolean mCellsDirty = true;
    private SheetModel.Sheet mSheet;
    private List<SheetModel.Sheet> mAllSheets;
    private GridListener mListener;

    private final Paint mBgPaint;
    private final Paint mTrayStrokePaint;
    private final Paint mKeyFillPaint;
    private final Paint mKeyStrokePaint;
    private final Paint mDashedPaint;
    private final Paint mLabelPaint;
    private final Paint mBadgePaint;
    private final Paint mDropLinePaint;
    private final Paint mGhostFillPaint;
    private final Paint mLockBodyPaint;
    private final Paint mLockShacklePaint;
    private final Paint.FontMetrics mFontMetrics = new Paint.FontMetrics();
    private final RectF mBoundsRect = new RectF();
    private final RectF mGhostRect = new RectF();
    private final RectF mLockRect = new RectF();

    private CellHit mDownCell;
    private float mDownX;
    private float mDownY;
    private float mMoveX;
    private float mMoveY;
    private boolean mDragging;
    private int mDropRow = -1;
    private int mDropIndex = -1;
    private float mDropLineX = -1f;
    private float mDropLineTop;
    private float mDropLineBottom;

    // Palette (mr_ui_*, read once: they do not change while the grid is on screen).
    private final int cBg;
    private final int cTrayStroke;
    private final int cKeyFill;
    private final int cKeyStroke;
    private final int cKeyLabel;
    private final int cPressedFill;
    private final int cDragFill;
    private final int cSheetFill;
    private final int cSheetStroke;
    private final int cSheetLabel;
    private final int cSpecialFill;
    private final int cSpecialStroke;
    private final int cSpacerFill;
    private final int cSpacerDragFill;
    private final int cSpacerLabel;
    private final int cDashed;
    private final int cAccent;
    private final int cAddFill;
    private final int cAddPressedFill;
    private final int cAddStroke;
    private final int cLockedFill;
    private final int cLockedStroke;
    private final int cLockedLabel;
    private final int cLockGlyph;
    private final int cLockHole;
    private final int cGhostFill;
    private final int cWidthBadge;

    public SheetGridView(Context context) {
        super(context);
        mRes = context.getResources();
        mDensity = mRes.getDisplayMetrics().density;
        mTouchSlop = ViewConfiguration.get(context).getScaledTouchSlop();
        mHandler = new Handler(Looper.getMainLooper());

        cBg = color("mr_ui_sunken");
        cTrayStroke = color("mr_ui_stroke");
        cKeyFill = color("mr_ui_raised");
        cKeyStroke = color("mr_ui_stroke_strong");
        cKeyLabel = color("mr_ui_text");
        cPressedFill = color("mr_ui_stroke_strong");
        cDragFill = color("mr_ui_sunken");
        cSheetFill = color("mr_ui_blue_soft");
        cSheetStroke = color("mr_ui_blue_line");
        cSheetLabel = color("mr_ui_blue");
        cSpecialFill = color("mr_ui_violet_soft");
        cSpecialStroke = color("mr_ui_violet_line");
        cSpacerFill = color("mr_ui_sunken");
        cSpacerDragFill = color("mr_ui_bg");
        cSpacerLabel = color("mr_ui_text3");
        cDashed = color("mr_ui_text_dis");
        cAccent = color("mr_ui_cyan");
        cAddFill = color("mr_ui_cyan_soft");
        cAddPressedFill = color("mr_ui_cyan_line");
        cAddStroke = color("mr_ui_cyan_line");
        cLockedFill = color("mr_ui_faint");
        cLockedStroke = color("mr_ui_stroke");
        cLockedLabel = color("mr_ui_text3");
        cLockGlyph = color("mr_ui_slate");
        cLockHole = color("mr_ui_sunken");
        cGhostFill = color("mr_ui_raised");
        cWidthBadge = color("mr_ui_text2");

        mBgPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mTrayStrokePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mKeyFillPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mKeyStrokePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mDashedPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mLabelPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mBadgePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mDropLinePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mGhostFillPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mLockBodyPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mLockShacklePaint = new Paint(Paint.ANTI_ALIAS_FLAG);

        mBgPaint.setStyle(Paint.Style.FILL);
        mBgPaint.setColor(cBg);

        mTrayStrokePaint.setStyle(Paint.Style.STROKE);
        mTrayStrokePaint.setStrokeWidth(Math.max(1f, dp(1f)));
        mTrayStrokePaint.setColor(cTrayStroke);

        mKeyStrokePaint.setStyle(Paint.Style.STROKE);
        mKeyStrokePaint.setStrokeWidth(Math.max(1f, dp(1f)));

        mDashedPaint.setStyle(Paint.Style.STROKE);
        mDashedPaint.setStrokeWidth(dp(1.2f));
        mDashedPaint.setColor(cDashed);
        mDashedPaint.setPathEffect(new DashPathEffect(new float[]{dp(4f), dp(3f)}, 0f));

        mLabelPaint.setTextAlign(Paint.Align.CENTER);
        mLabelPaint.setTypeface(SheetUi.TF_MEDIUM);

        mBadgePaint.setTextAlign(Paint.Align.RIGHT);
        mBadgePaint.setTextSize(dp(8.5f));
        mBadgePaint.setTypeface(SheetUi.TF_MEDIUM);

        mDropLinePaint.setColor(cAccent);
        mDropLinePaint.setStrokeWidth(dp(3f));
        mDropLinePaint.setStrokeCap(Paint.Cap.ROUND);

        mGhostFillPaint.setStyle(Paint.Style.FILL);
        mGhostFillPaint.setColor(cGhostFill);

        mLockBodyPaint.setStyle(Paint.Style.FILL);
        mLockShacklePaint.setStyle(Paint.Style.STROKE);
        mLockShacklePaint.setStrokeCap(Paint.Cap.ROUND);
        mLockShacklePaint.setStrokeJoin(Paint.Join.ROUND);

        mLongPressRunnable = new Runnable() {
            public void run() {
                if (mDownCell == null || mDownCell.kind != CellHit.KIND_KEY || mDragging) return;
                mDragging = true;
                performHapticFeedback(0);
                ViewParent parent = getParent();
                if (parent != null) parent.requestDisallowInterceptTouchEvent(true);
                computeDropTarget(mMoveX, mMoveY);
                invalidate();
            }
        };
    }

    // ------------------------------------------------------------------ resources by name

    /** Color of the settings palette (@color/mr_ui_*) by name. */
    private int color(String name) {
        return mRes.getColor(mRes.getIdentifier(name, "color", getContext().getPackageName()));
    }

    /** Text of mr_strings.xml by name, in the language of the app. */
    private String t(String name) {
        int id = mRes.getIdentifier(name, "string", getContext().getPackageName());
        return id == 0 ? name : mRes.getString(id);
    }

    private float dp(float v) {
        return v * mDensity;
    }

    // ------------------------------------------------------------------ data

    public void setGridListener(GridListener listener) {
        mListener = listener;
    }

    public void setData(SheetModel.Sheet sheet, List<SheetModel.Sheet> allSheets) {
        mSheet = sheet;
        mAllSheets = allSheets;
        mCellsDirty = true;
        requestLayout();
        invalidate();
    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        super.onSizeChanged(w, h, oldw, oldh);
        if (w != oldw || h != oldh) mCellsDirty = true;
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int width = MeasureSpec.getSize(widthMeasureSpec);
        int rows = (mSheet != null && !mSheet.rows.isEmpty()) ? Math.min(mSheet.rows.size(), 6) : 1;
        int blocks = rows + 1;   // the rows plus the locked bottom row
        int height = Math.round(dp(10f)) * 2 + Math.round(dp(48f)) * blocks + (blocks - 1) * Math.round(dp(5f));
        setMeasuredDimension(width, resolveSize(height, heightMeasureSpec));
    }

    // ------------------------------------------------------------------ cells

    /** Lays the cells out again after a change of the sheet, of the width or of the labels. */
    private void ensureCellsBuilt() {
        if (!mCellsDirty) return;
        mCellsDirty = false;
        mCells.clear();
        if (mSheet == null) return;
        int width = getWidth();
        if (width <= 0) return;

        float padX = dp(8f);          // left margin of the keys
        float top = dp(10f);          // top of the first row
        float gap = dp(4f);           // gap between the keys of a row
        float rowGap = dp(5f);        // gap between the rows
        float keyH = dp(48f);         // height of a key
        float usableW = Math.max(10f, width - (2f * padX));
        int rowCount = Math.min(mSheet.rows.size(), 6);

        for (int r = 0; r < rowCount; r++) {
            SheetModel.Row row = mSheet.rows.get(r);
            boolean lastRow = (r == rowCount - 1);   // the last row has the locked "⌫", so one key less
            int maxKeys = lastRow ? 9 : 10;
            boolean showAdd = row.keys.size() < maxKeys;
            float addW = showAdd ? dp(30f) : 0f;
            float rowW = showAdd ? Math.max(20f, (usableW - addW) - gap) : usableW;

            float totalWeight = 0f;
            for (int k = 0; k < row.keys.size(); k++) {
                totalWeight += SheetModel.clampWidth(row.keys.get(k).width);
            }
            if (lastRow) totalWeight += 1.5f;   // the weight of the locked "⌫"

            if (!row.keys.isEmpty() || lastRow) {
                int slots = row.keys.size() + (lastRow ? 1 : 0);
                float availW = Math.max(10f, rowW - (Math.max(0, slots - 1) * gap));
                float x = padX;
                for (int k = 0; k < row.keys.size(); k++) {
                    SheetModel.KeySpec key = row.keys.get(k);
                    float w = (SheetModel.clampWidth(key.width) / totalWeight) * availW;
                    mCells.add(new CellHit(CellHit.KIND_KEY, r, k, new RectF(x, top, x + w, top + keyH), key,
                            SheetKeyboardBuilder.effectiveDisplayLabel(key, mAllSheets)));
                    x += w + gap;
                }
                if (lastRow) {
                    float w = (1.5f / totalWeight) * availW;
                    mCells.add(new CellHit(CellHit.KIND_LOCKED_DELETE, r, row.keys.size(),
                            new RectF(x, top, x + w, top + keyH), null, "⌫"));
                }
                if (showAdd) {
                    float right = padX + usableW;
                    mCells.add(new CellHit(CellHit.KIND_ADD, r, row.keys.size(),
                            new RectF(right - addW, top, right, top + keyH), null, "+"));
                }
            } else {
                mCells.add(new CellHit(CellHit.KIND_ADD, r, 0, new RectF(padX, top, padX + usableW, top + keyH),
                        null, t("mr_grid_add_key")));
            }
            top += keyH + rowGap;
        }

        String[] bottom = {SheetModel.sanitizeBadge(mSheet.badge, "123"), ",", "␣", ".", "⏎"};
        float bottomW = usableW - (gap * 4f);
        for (int i = 0; i < 5; i++) {
            float w = BOTTOM_WEIGHTS[i] * bottomW;
            mCells.add(new CellHit(CellHit.KIND_LOCKED_BOTTOM, rowCount, i,
                    new RectF(padX, top, padX + w, top + keyH), null, bottom[i]));
            padX += w + gap;
        }
    }

    // ------------------------------------------------------------------ drawing

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        ensureCellsBuilt();

        // the rounded panel of the grid
        float half = mTrayStrokePaint.getStrokeWidth() * 0.5f;
        mBoundsRect.set(half, half, getWidth() - half, getHeight() - half);
        float radius = dp(14f);
        canvas.drawRoundRect(mBoundsRect, radius, radius, mBgPaint);
        canvas.drawRoundRect(mBoundsRect, radius, radius, mTrayStrokePaint);

        float keyRadius = dp(7.5f);
        int size = mCells.size();
        for (int i = 0; i < size; i++) {
            CellHit cell = mCells.get(i);
            boolean pressed = !mDragging && mDownCell == cell;
            boolean dragSource = mDragging && mDownCell != null && cell.kind == CellHit.KIND_KEY
                    && cell.rowIdx == mDownCell.rowIdx && cell.keyIdx == mDownCell.keyIdx;
            if (cell.kind == CellHit.KIND_ADD) {
                drawAddCell(canvas, cell, keyRadius, pressed);
            } else if (cell.kind == CellHit.KIND_KEY) {
                drawKeyCell(canvas, cell, keyRadius, pressed, dragSource);
            } else {
                drawLockedCell(canvas, cell, keyRadius);
            }
        }

        if (mDragging && mDownCell != null) {
            if (mDropLineX >= 0f) {
                canvas.drawLine(mDropLineX, mDropLineTop, mDropLineX, mDropLineBottom, mDropLinePaint);
            }
            // the key follows the finger as a floating ghost, above it
            float halfW = Math.max(dp(44f), mDownCell.rect.width()) * 0.5f;
            float h = mDownCell.rect.height();
            mGhostRect.set(mMoveX - halfW, mMoveY - (1.15f * h), mMoveX + halfW, mMoveY - (h * 0.15f));
            canvas.drawRoundRect(mGhostRect, keyRadius, keyRadius, mGhostFillPaint);
            mKeyStrokePaint.setColor(cAccent);
            canvas.drawRoundRect(mGhostRect, keyRadius, keyRadius, mKeyStrokePaint);
            mLabelPaint.setColor(cKeyLabel);
            mLabelPaint.setTextSize(dp(14f));
            String label = (mDownCell.shortLabel != null && !mDownCell.shortLabel.isEmpty())
                    ? mDownCell.shortLabel : "␣";
            drawCenteredText(canvas, label, mGhostRect, mLabelPaint);
        }
    }

    /** The "+" chip of a row (and the whole cell of an empty row). */
    private void drawAddCell(Canvas canvas, CellHit cell, float keyRadius, boolean pressed) {
        mKeyFillPaint.setColor(pressed ? cAddPressedFill : cAddFill);
        canvas.drawRoundRect(cell.rect, keyRadius, keyRadius, mKeyFillPaint);
        mKeyStrokePaint.setColor(cAddStroke);
        canvas.drawRoundRect(cell.rect, keyRadius, keyRadius, mKeyStrokePaint);
        mLabelPaint.setColor(cAccent);
        mLabelPaint.setTextSize(dp(cell.displayLabel.length() <= 1 ? 17f : 12.5f));
        drawCenteredText(canvas, cell.displayLabel, cell.rect, mLabelPaint);
    }

    /** A key of the sheet: the type of the action chooses the colors, the drag and the press win over it. */
    private void drawKeyCell(Canvas canvas, CellHit cell, float keyRadius, boolean pressed, boolean dragSource) {
        SheetModel.KeySpec spec = cell.spec;
        if (SheetModel.TYPE_SPACER.equals(spec.type)) {
            mKeyFillPaint.setColor(dragSource ? cSpacerDragFill : cSpacerFill);
            canvas.drawRoundRect(cell.rect, keyRadius, keyRadius, mKeyFillPaint);
            canvas.drawRoundRect(cell.rect, keyRadius, keyRadius, mDashedPaint);
            mLabelPaint.setColor(cSpacerLabel);
            mLabelPaint.setTextSize(dp(10f));
            drawCenteredText(canvas, "␣", cell.rect, mLabelPaint);
            return;
        }
        boolean sheetTarget = SheetModel.TYPE_TASKER.equals(spec.type) || SheetModel.TYPE_SHEET.equals(spec.type);
        boolean special = SheetModel.TYPE_SPECIAL.equals(spec.type);
        int fill;
        int stroke;
        if (dragSource) {
            fill = cDragFill;
            stroke = cAccent;
        } else if (pressed) {
            fill = cPressedFill;
            stroke = cAccent;
        } else if (sheetTarget) {
            fill = cSheetFill;
            stroke = cSheetStroke;
        } else if (special) {
            fill = cSpecialFill;
            stroke = cSpecialStroke;
        } else {
            fill = cKeyFill;
            stroke = cKeyStroke;
        }
        mKeyFillPaint.setColor(fill);
        mKeyStrokePaint.setColor(stroke);
        canvas.drawRoundRect(cell.rect, keyRadius, keyRadius, mKeyFillPaint);
        canvas.drawRoundRect(cell.rect, keyRadius, keyRadius, mKeyStrokePaint);

        int len = cell.shortLabel.length();
        mLabelPaint.setTextSize(dp(len <= 2 ? 14.5f : len <= 4 ? 12f : 10.5f));
        mLabelPaint.setColor(dragSource ? cSpacerLabel : sheetTarget ? cSheetLabel : cKeyLabel);
        drawCenteredText(canvas, cell.shortLabel, cell.rect, mLabelPaint);

        if (spec.hasAnyPopup()) {
            mBadgePaint.setColor(cAccent);
            canvas.drawText("•••", cell.rect.right - dp(4f), cell.rect.top + dp(9f), mBadgePaint);
        }
        if (cell.widthBadge != null && cell.rect.width() > dp(28f)) {
            mBadgePaint.setColor(cWidthBadge);
            canvas.drawText(cell.widthBadge, cell.rect.right - dp(3f), cell.rect.bottom - dp(3f), mBadgePaint);
        }
    }

    /** The locked cells: the "⌫" of the last row and the whole bottom row (they carry the padlock). */
    private void drawLockedCell(Canvas canvas, CellHit cell, float keyRadius) {
        mKeyFillPaint.setColor(cLockedFill);
        canvas.drawRoundRect(cell.rect, keyRadius, keyRadius, mKeyFillPaint);
        mKeyStrokePaint.setColor(cLockedStroke);
        canvas.drawRoundRect(cell.rect, keyRadius, keyRadius, mKeyStrokePaint);
        mLabelPaint.setColor(cLockedLabel);
        mLabelPaint.setTextSize(dp(12.5f));
        // the label sits a bit above the middle, to leave room for the padlock in the corner
        mLockRect.set(cell.rect.left, cell.rect.top + dp(6.5f), cell.rect.right, cell.rect.bottom);
        drawCenteredText(canvas, cell.displayLabel, mLockRect, mLabelPaint);
        drawLockIcon(canvas, cell.rect);
    }

    private void drawCenteredText(Canvas canvas, String text, RectF rect, Paint paint) {
        paint.getFontMetrics(mFontMetrics);
        float y = rect.centerY() - ((mFontMetrics.ascent + mFontMetrics.descent) * 0.5f);
        canvas.drawText(text, rect.centerX(), y, paint);
    }

    /** Small padlock in the top-right corner of a locked cell. */
    private void drawLockIcon(Canvas canvas, RectF rect) {
        float right = rect.right - dp(2.45f);
        float left = right - dp(7.7f);
        float center = left + dp(3.85f);
        float top = rect.top;

        mLockShacklePaint.setColor(cLockGlyph);
        mLockShacklePaint.setStrokeWidth(dp(1.26f));
        float shackleR = dp(2.275f);
        float archBottom = dp(6.65f) + top;
        mLockRect.set(center - shackleR, dp(2.1f) + top, center + shackleR, archBottom);
        canvas.drawArc(mLockRect, 180f, 180f, false, mLockShacklePaint);

        float legTop = dp(4.375f) + top;
        float legBottom = dp(6.44f) + top;
        float legLeft = center - shackleR;
        canvas.drawLine(legLeft, legTop, legLeft, legBottom, mLockShacklePaint);
        float legRight = center + shackleR;
        canvas.drawLine(legRight, legTop, legRight, legBottom, mLockShacklePaint);

        mLockRect.set(left, dp(6.16f) + top, right, dp(11.9f) + top);
        mLockBodyPaint.setColor(cLockGlyph);
        float bodyR = dp(1.4f);
        canvas.drawRoundRect(mLockRect, bodyR, bodyR, mLockBodyPaint);

        // the keyhole
        mLockBodyPaint.setColor(cLockHole);
        canvas.drawCircle(center, dp(8.4f) + top, dp(0.875f), mLockBodyPaint);
        mLockShacklePaint.setColor(cLockHole);
        mLockShacklePaint.setStrokeWidth(dp(1.015f));
        canvas.drawLine(center, dp(8.68f) + top, center, dp(10.43f) + top, mLockShacklePaint);
    }

    // ------------------------------------------------------------------ touch

    private CellHit hitTest(float x, float y) {
        ensureCellsBuilt();
        int size = mCells.size();
        for (int i = 0; i < size; i++) {
            CellHit cell = mCells.get(i);
            if (cell.rect.contains(x, y)) return cell;
        }
        return null;
    }

    /** Row and position where the dragged key drops, and the cyan line that shows it. */
    private void computeDropTarget(float x, float y) {
        if (mSheet == null || mSheet.rows.isEmpty()) return;
        int rowCount = Math.min(mSheet.rows.size(), 6);
        float padTop = dp(10f);
        float keyH = dp(48f);
        float rowGap = dp(5f);

        // the row nearest to the finger
        int row = 0;
        float best = Float.MAX_VALUE;
        for (int r = 0; r < rowCount; r++) {
            float d = Math.abs(y - (((r * (keyH + rowGap)) + padTop) + (0.5f * keyH)));
            if (d < best) {
                row = r;
                best = d;
            }
        }

        // a full row does not take a key from another row
        int maxKeys = (row == rowCount - 1) ? 9 : 10;
        SheetModel.Row target = mSheet.rows.get(row);
        if (mDownCell != null && row != mDownCell.rowIdx && target.keys.size() >= maxKeys) {
            mDropRow = -1;
            mDropIndex = -1;
            mDropLineX = -1f;
            return;
        }

        mRowHitsScratch.clear();
        int size = mCells.size();
        for (int i = 0; i < size; i++) {
            CellHit cell = mCells.get(i);
            if (cell.kind == CellHit.KIND_KEY && cell.rowIdx == row) mRowHitsScratch.add(cell);
        }

        mDropLineTop = padTop + (row * (rowGap + keyH));
        mDropLineBottom = mDropLineTop + keyH;
        mDropRow = row;

        if (mRowHitsScratch.isEmpty()) {
            mDropIndex = 0;
            mDropLineX = dp(10f);
            return;
        }

        // before the first key whose middle is to the right of the finger, or after the last one
        int index = mRowHitsScratch.size();
        int hits = mRowHitsScratch.size();
        for (int i = 0; i < hits; i++) {
            CellHit cell = mRowHitsScratch.get(i);
            if (x < cell.rect.centerX()) {
                mDropLineX = cell.rect.left - dp(2f);
                index = i;
                break;
            }
        }
        if (index == mRowHitsScratch.size()) {
            mDropLineX = mRowHitsScratch.get(mRowHitsScratch.size() - 1).rect.right + dp(2f);
        }
        mDropIndex = index;
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        float x = event.getX();
        float y = event.getY();
        switch (event.getActionMasked()) {
            case MotionEvent.ACTION_DOWN: {
                mDownX = x;
                mDownY = y;
                mMoveX = x;
                mMoveY = y;
                mDragging = false;
                mDropRow = -1;
                mDropIndex = -1;
                mDropLineX = -1f;
                mDownCell = hitTest(x, y);
                if (mDownCell != null && mDownCell.kind == CellHit.KIND_KEY) {
                    mHandler.postDelayed(mLongPressRunnable, ViewConfiguration.getLongPressTimeout());
                }
                if (mDownCell == null) return false;
                invalidate();
                return true;
            }
            case MotionEvent.ACTION_UP: {
                mHandler.removeCallbacks(mLongPressRunnable);
                if (mDragging && mDownCell != null) {
                    // the drop: the key moves inside the sheet
                    int fromRow = mDownCell.rowIdx;
                    int fromKey = mDownCell.keyIdx;
                    int toRow = mDropRow;
                    int toIndex = mDropIndex;
                    mDragging = false;
                    mDownCell = null;
                    invalidate();
                    if (toRow >= 0 && toIndex >= 0 && mListener != null) {
                        mListener.onKeyDragged(fromRow, fromKey, toRow, toIndex);
                    }
                } else if (mDownCell != null) {
                    // the tap: only when the finger did not walk away from the cell
                    float dx = x - mDownX;
                    float dy = y - mDownY;
                    float slop = mTouchSlop * 1.5f;
                    CellHit cell = mDownCell;
                    mDownCell = null;
                    invalidate();
                    if ((dx * dx) + (dy * dy) <= slop * slop && mListener != null) {
                        if (cell.kind == CellHit.KIND_KEY) {
                            mListener.onKeyTapped(cell.rowIdx, cell.keyIdx);
                        } else if (cell.kind == CellHit.KIND_ADD) {
                            mListener.onAddKeyTapped(cell.rowIdx);
                        } else if (cell.kind == CellHit.KIND_LOCKED_DELETE) {
                            mListener.onLockedKeyTapped(true);
                        } else if (cell.kind == CellHit.KIND_LOCKED_BOTTOM) {
                            mListener.onLockedKeyTapped(false);
                        }
                    }
                }
                return true;
            }
            case MotionEvent.ACTION_MOVE: {
                mMoveX = x;
                mMoveY = y;
                if (!mDragging) {
                    float dx = x - mDownX;
                    float dy = y - mDownY;
                    if ((dx * dx) + (dy * dy) > mTouchSlop * mTouchSlop) {
                        // the finger walked away before the long press: it is a scroll, not a drag
                        mHandler.removeCallbacks(mLongPressRunnable);
                        if (mDownCell != null) {
                            mDownCell = null;
                            invalidate();
                        }
                    }
                } else {
                    computeDropTarget(x, y);
                    invalidate();
                }
                return true;
            }
            case MotionEvent.ACTION_CANCEL: {
                mHandler.removeCallbacks(mLongPressRunnable);
                mDragging = false;
                mDownCell = null;
                invalidate();
                return true;
            }
            default:
                return super.onTouchEvent(event);
        }
    }

    /** One cell of the grid: what it is, where it is, and the labels to draw. */
    private static final class CellHit {
        static final int KIND_KEY = 0;
        static final int KIND_ADD = 1;
        static final int KIND_LOCKED_DELETE = 2;
        static final int KIND_LOCKED_BOTTOM = 3;

        final int kind;
        final int rowIdx;
        final int keyIdx;
        final RectF rect;
        final SheetModel.KeySpec spec;
        final String displayLabel;
        final String shortLabel;
        final String widthBadge;

        CellHit(int kind, int rowIdx, int keyIdx, RectF rect, SheetModel.KeySpec spec, String label) {
            this.kind = kind;
            this.rowIdx = rowIdx;
            this.keyIdx = keyIdx;
            this.rect = rect;
            this.spec = spec;
            this.displayLabel = label == null ? "" : label;
            String flat = displayLabel.indexOf(10) >= 0 ? displayLabel.replace("\n", "↵") : displayLabel;
            this.shortLabel = flat.length() > 7 ? flat.substring(0, 6) + "…" : flat;
            if (spec == null || Math.abs(spec.width - 1f) <= 0.05f) {
                this.widthBadge = null;
            } else if (Math.abs(spec.width - Math.round(spec.width)) < 0.01f) {
                this.widthBadge = Math.round(spec.width) + "x";
            } else {
                this.widthBadge = spec.width + "x";
            }
        }
    }
}
