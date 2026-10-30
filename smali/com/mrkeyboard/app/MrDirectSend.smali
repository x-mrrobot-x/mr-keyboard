.class final Lcom/mrkeyboard/app/MrDirectSend;
.super Ljava/lang/Object;

# UI-thread handoff. True means accepted, not proof of subsequent recipient read.
.method static send(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 .locals 8
 if-eqz p0, :failed
 if-eqz p1, :failed
 if-eqz p2, :failed
 invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;
 move-result-object v0
 invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;
 move-result-object v1
 if-eqz v0, :share
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
 if-nez v2, :accepted
 goto :share
 :commit_failed
 move-exception v2
 :share
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
 :accepted
 const/4 v0, 0x1
 return v0
 :share_failed
 move-exception v3
 :failed
 const/4 v0, 0x0
 return v0
.end method
