.class interface abstract Lcom/mrkeyboard/app/MrImportAi$Sender;
.super Ljava/lang/Object;
.source "MrImportAi.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrImportAi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x608
    name = "Sender"
.end annotation


# virtual methods
.method public abstract send(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrImportAi$Fail;
        }
    .end annotation
.end method
