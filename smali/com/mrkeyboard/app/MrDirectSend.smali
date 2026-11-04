.class final Lcom/mrkeyboard/app/MrDirectSend;
.super Ljava/lang/Object;

.method static send(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 .locals 1
 if-eqz p0, :failed
 if-eqz p1, :failed
 if-eqz p2, :failed
 invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrDirectSend;->commit(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 move-result v0
 if-nez v0, :done
 invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrDirectSend;->share(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 move-result v0
 :done
 return v0
 :failed
 const/4 v0, 0x0
 return v0
.end method

# UI-thread handoff. True means accepted, not proof of subsequent recipient read.
.method static commit(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 .locals 5
 if-eqz p0, :failed
 if-eqz p1, :failed
 if-eqz p2, :failed
 invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;
 move-result-object v0
 invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;
 move-result-object v1
 if-eqz v0, :failed
 if-eqz v1, :failed
 :try_commit
 new-instance v2, Landroid/content/ClipDescription;
 const/4 v3, 0x1
 new-array v3, v3, [Ljava/lang/String;
 const/4 v4, 0x0
 aput-object p2, v3, v4
 const-string v4, "attachment"
 invoke-direct {v2, v4, v3}, Landroid/content/ClipDescription;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;)V
 invoke-static {v0, v1, p1, v2}, Lcom/mrkeyboard/app/MrMediaHelper;->commitImage(Landroid/view/inputmethod/InputConnection;Landroid/view/inputmethod/EditorInfo;Landroid/net/Uri;Landroid/content/ClipDescription;)Z
 move-result v2
 :end_commit
 .catch Ljava/lang/Exception; {:try_commit .. :end_commit} :commit_failed
 return v2
 :commit_failed
 move-exception v2
 :failed
 const/4 v0, 0x0
 return v0
.end method

.method static share(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 .locals 5
 if-eqz p0, :failed
 if-eqz p1, :failed
 if-eqz p2, :failed
 invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;
 move-result-object v1
 if-eqz v1, :failed
 iget-object v2, v1, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;
 if-eqz v2, :failed
 invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
 move-result-object v3
 invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
 move-result v3
 if-nez v3, :failed
 :try_share
 # ClipData + FLAG_GRANT_READ_URI_PERMISSION ask Android for a temporary
 # activity-scoped grant. startActivity may reject a non-delegable URI.
 # Avoid grantUriPermission(), whose explicit grant could outlive the activity.
 new-instance v3, Landroid/content/Intent;
 const-string v4, "android.intent.action.SEND"
 invoke-direct {v3, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
 invoke-virtual {v3, p2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;
 const-string v4, "android.intent.extra.STREAM"
 invoke-virtual {v3, v4, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;
 invoke-virtual {v3, v2}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;
 const-string v4, "attachment"
 invoke-static {v4, p1}, Landroid/content/ClipData;->newRawUri(Ljava/lang/CharSequence;Landroid/net/Uri;)Landroid/content/ClipData;
 move-result-object v4
 invoke-virtual {v3, v4}, Landroid/content/Intent;->setClipData(Landroid/content/ClipData;)V
 const v4, 0x10000001
 invoke-virtual {v3, v4}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
 invoke-virtual {p0, v3}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
 :end_share
 .catch Ljava/lang/Exception; {:try_share .. :end_share} :share_failed
 const/4 v0, 0x1
 return v0
 :share_failed
 move-exception v3
 :failed
 const/4 v0, 0x0
 return v0
.end method

.method static shareMany(Lcom/mrkeyboard/app/LatinIME;Ljava/util/ArrayList;Ljava/util/ArrayList;)Z
 .locals 9
 if-eqz p0, :failed
 if-eqz p1, :failed
 invoke-virtual {p1}, Ljava/util/ArrayList;->isEmpty()Z
 move-result v0
 if-nez v0, :failed
 invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;
 move-result-object v1
 if-eqz v1, :failed
 iget-object v2, v1, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;
 if-eqz v2, :failed
 invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
 move-result-object v3
 invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
 move-result v3
 if-nez v3, :failed
 :try_share
 new-instance v3, Landroid/content/Intent;
 const-string v4, "android.intent.action.SEND_MULTIPLE"
 invoke-direct {v3, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
 invoke-static {p2}, Lcom/mrkeyboard/app/MrDirectSend;->commonType(Ljava/util/ArrayList;)Ljava/lang/String;
 move-result-object v4
 invoke-virtual {v3, v4}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;
 const-string v4, "android.intent.extra.STREAM"
 invoke-virtual {v3, v4, p1}, Landroid/content/Intent;->putParcelableArrayListExtra(Ljava/lang/String;Ljava/util/ArrayList;)Landroid/content/Intent;
 invoke-virtual {v3, v2}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;
 const/4 v4, 0x0
 invoke-virtual {p1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v5
 check-cast v5, Landroid/net/Uri;
 const-string v6, "attachment"
 invoke-static {v6, v5}, Landroid/content/ClipData;->newRawUri(Ljava/lang/CharSequence;Landroid/net/Uri;)Landroid/content/ClipData;
 move-result-object v6
 invoke-virtual {p1}, Ljava/util/ArrayList;->size()I
 move-result v7
 const/4 v4, 0x1
 :loop
 if-ge v4, v7, :loop_end
 invoke-virtual {p1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v5
 check-cast v5, Landroid/net/Uri;
 new-instance v8, Landroid/content/ClipData$Item;
 invoke-direct {v8, v5}, Landroid/content/ClipData$Item;-><init>(Landroid/net/Uri;)V
 invoke-virtual {v6, v8}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V
 add-int/lit8 v4, v4, 0x1
 goto :loop
 :loop_end
 invoke-virtual {v3, v6}, Landroid/content/Intent;->setClipData(Landroid/content/ClipData;)V
 const v4, 0x10000001
 invoke-virtual {v3, v4}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
 invoke-virtual {p0, v3}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
 :end_share
 .catch Ljava/lang/Exception; {:try_share .. :end_share} :share_failed
 const/4 v0, 0x1
 return v0
 :share_failed
 move-exception v3
 :failed
 const/4 v0, 0x0
 return v0
.end method

.method private static commonType(Ljava/util/ArrayList;)Ljava/lang/String;
 .locals 8
 if-eqz p0, :any
 invoke-virtual {p0}, Ljava/util/ArrayList;->size()I
 move-result v0
 if-lez v0, :any
 const/4 v3, 0x0
 invoke-virtual {p0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v1
 check-cast v1, Ljava/lang/String;
 if-eqz v1, :any
 const/16 v6, 0x2f
 invoke-virtual {v1, v6}, Ljava/lang/String;->indexOf(I)I
 move-result v6
 if-ltz v6, :any
 add-int/lit8 v6, v6, 0x1
 invoke-virtual {v1, v3, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;
 move-result-object v2
 const/4 v3, 0x1
 const/4 v4, 0x1
 :loop
 if-ge v3, v0, :done
 invoke-virtual {p0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v5
 check-cast v5, Ljava/lang/String;
 if-eqz v5, :any
 invoke-virtual {v1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
 move-result v6
 if-nez v6, :next
 invoke-virtual {v5, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
 move-result v6
 if-eqz v6, :any
 const/4 v4, 0x0
 :next
 add-int/lit8 v3, v3, 0x1
 goto :loop
 :done
 if-eqz v4, :prefix
 return-object v1
 :prefix
 const-string v6, "*"
 invoke-virtual {v2, v6}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
 move-result-object v2
 return-object v2
 :any
 const-string v6, "*/*"
 return-object v6
.end method
