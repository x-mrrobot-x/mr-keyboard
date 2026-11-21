.class final Lcom/mrkeyboard/app/MrBackdrop$Spec;
.super Ljava/lang/Object;
.source "MrBackdrop.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrBackdrop;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Spec"
.end annotation


# static fields
.field static final NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;


# instance fields
.field final dx:I

.field final dy:I

.field final index:I

.field final kind:I

.field final stamp:J

.field final zoom:I


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v1, 0x0

    .line 161
    new-instance v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    const/16 v3, 0x64

    const-wide/16 v6, 0x0

    move v2, v1

    move v4, v1

    move v5, v1

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrBackdrop$Spec;-><init>(IIIIIJ)V

    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    return-void
.end method

.method private constructor <init>(IIIIIJ)V
    .locals 0

    .prologue
    .line 152
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 153
    iput p1, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    .line 154
    iput p2, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    .line 155
    iput p3, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    .line 156
    iput p4, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    .line 157
    iput p5, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    .line 158
    iput-wide p6, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->stamp:J

    .line 159
    return-void
.end method

.method static color(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 8

    .prologue
    const/4 v4, 0x0

    .line 164
    if-ltz p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    array-length v0, v0

    if-ge p0, v0, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    const/4 v1, 0x4

    const/16 v3, 0x64

    const-wide/16 v6, 0x0

    move v2, p0

    move v5, v4

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrBackdrop$Spec;-><init>(IIIIIJ)V

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    goto :goto_0
.end method

.method static gradient(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 8

    .prologue
    const/4 v4, 0x0

    .line 168
    if-ltz p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->GRADS:[Lcom/mrkeyboard/app/MrBackdrop$Grad;

    array-length v0, v0

    if-ge p0, v0, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    const/4 v1, 0x1

    const/16 v3, 0x64

    const-wide/16 v6, 0x0

    move v2, p0

    move v5, v4

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrBackdrop$Spec;-><init>(IIIIIJ)V

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    goto :goto_0
.end method

.method static image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 9

    .prologue
    const/16 v6, -0x64

    const/16 v5, 0x64

    .line 177
    new-instance v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/16 v3, 0x190

    invoke-static {p0, v5, v3}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v3

    invoke-static {p1, v6, v5}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v4

    invoke-static {p2, v6, v5}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v5

    move-wide v6, p3

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrBackdrop$Spec;-><init>(IIIIIJ)V

    return-object v0
.end method

.method static parse(Ljava/lang/String;)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 6

    .prologue
    const/4 v1, 0x2

    .line 187
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-ge v0, v1, :cond_1

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 202
    :goto_0
    return-object v0

    .line 189
    :cond_1
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 190
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    sparse-switch v1, :sswitch_data_0

    .line 199
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    goto :goto_0

    .line 191
    :sswitch_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->color(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    goto :goto_0

    .line 192
    :sswitch_1
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->gradient(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    goto :goto_0

    .line 193
    :sswitch_2
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->scene(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    goto :goto_0

    .line 195
    :sswitch_3
    const-string v1, ","

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v0

    .line 196
    array-length v1, v0

    const/4 v2, 0x4

    if-eq v1, v2, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    goto :goto_0

    .line 197
    :cond_2
    const/4 v1, 0x0

    aget-object v1, v0, v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    const/4 v2, 0x1

    aget-object v2, v0, v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x2

    aget-object v3, v0, v3

    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    const/4 v4, 0x3

    aget-object v0, v0, v4

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    invoke-static {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 201
    :catch_0
    move-exception v0

    .line 202
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    goto :goto_0

    .line 190
    :sswitch_data_0
    .sparse-switch
        0x63 -> :sswitch_0
        0x67 -> :sswitch_1
        0x69 -> :sswitch_3
        0x73 -> :sswitch_2
    .end sparse-switch
.end method

.method static scene(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 8

    .prologue
    .line 173
    invoke-static {p0}, Lcom/mrkeyboard/app/MrScenes;->valid(I)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    const/4 v1, 0x2

    const/16 v3, 0x64

    const/4 v4, 0x0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrScenes;->focus(I)I

    move-result v5

    const-wide/16 v6, 0x0

    move v2, p0

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrBackdrop$Spec;-><init>(IIIIIJ)V

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    goto :goto_0
.end method


# virtual methods
.method format()Ljava/lang/String;
    .locals 4

    .prologue
    .line 208
    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 213
    const-string v0, ""

    :goto_0
    return-object v0

    .line 209
    :pswitch_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "c"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 210
    :pswitch_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "g"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 211
    :pswitch_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "s"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 212
    :pswitch_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "i"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v2, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->stamp:J

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 208
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
    .end packed-switch
.end method

.method moved(III)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 2

    .prologue
    .line 182
    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget-wide v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->stamp:J

    invoke-static {p1, p2, p3, v0, v1}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object p0

    :cond_0
    return-object p0
.end method

.method same(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z
    .locals 2

    .prologue
    .line 218
    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
