.class public Lcom/mrkeyboard/app/MrEmoteAdp;
.super Landroid/widget/BaseAdapter;
.source "MrEmoteAdp.java"

.field mRows:Ljava/util/ArrayList;


.method public constructor <init>(Ljava/util/ArrayList;)V
    .locals 0

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    iput-object p1, p0, Lcom/mrkeyboard/app/MrEmoteAdp;->mRows:Ljava/util/ArrayList;

    return-void
.end method

.method public setRows(Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Lcom/mrkeyboard/app/MrEmoteAdp;->mRows:Ljava/util/ArrayList;

    invoke-virtual {p0}, Landroid/widget/BaseAdapter;->notifyDataSetChanged()V

    return-void
.end method

.method public getCount()I
    .locals 1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrEmoteAdp;->mRows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrEmoteAdp;->mRows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x2

    return v0
.end method

.method public getItemViewType(I)I
    .locals 2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrEmoteAdp;->mRows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_row

    const/4 v0, 0x0

    return v0

    :cond_row
    const/4 v0, 0x1

    return v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 5

    iget-object v0, p0, Lcom/mrkeyboard/app/MrEmoteAdp;->mRows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    instance-of v2, v1, Ljava/lang/String;

    if-eqz v2, :cond_row

    check-cast v1, Ljava/lang/String;

    if-nez p2, :cond_hdr_have

    invoke-static {}, Lcom/mrkeyboard/app/MrEmotes;->header()Landroid/widget/TextView;

    move-result-object p2

    :cond_hdr_have
    check-cast p2, Landroid/widget/TextView;

    invoke-virtual {p2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-object p2

    :cond_row
    check-cast v1, [Ljava/lang/String;

    if-nez p2, :cond_row_have

    array-length v2, v1

    invoke-static {v2}, Lcom/mrkeyboard/app/MrEmotes;->row(I)Landroid/view/View;

    move-result-object p2

    :cond_row_have
    check-cast p2, Landroid/view/ViewGroup;

    const/4 v2, 0x0

    :goto_fill
    array-length v3, v1

    if-ge v2, v3, :cond_done

    invoke-virtual {p2, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    aget-object v4, v1, v2

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_fill

    :cond_done
    return-object p2
.end method
