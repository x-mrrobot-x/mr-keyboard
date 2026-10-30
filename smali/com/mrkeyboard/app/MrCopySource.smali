.class final Lcom/mrkeyboard/app/MrCopySource;
.super Ljava/lang/Object;

# Exact-row metadata lookup, used only by copy workers. Failure disables reuse.
.method static version(IJ)Ljava/lang/String;
 .locals 9
 const/4 v6, 0x0
 :try_start
 sget-object v7, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;
 if-eqz v7, :none
 const/4 v0, 0x2
 if-ne p0, v0, :media
 const-string v0, "external"
 invoke-static {v0}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;
 move-result-object v1
 invoke-static {v1, p1, p2}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;
 move-result-object v1
 goto :uri_ready
 :media
 const/4 v0, 0x1
 if-ne p0, v0, :image
 sget-object v1, Landroid/provider/MediaStore$Video$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;
 neg-long v3, p1
 invoke-static {v1, v3, v4}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;
 move-result-object v1
 goto :uri_ready
 :image
 sget-object v1, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;
 invoke-static {v1, p1, p2}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;
 move-result-object v1
 :uri_ready
 invoke-virtual {v7}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
 move-result-object v0
 const/4 v2, 0x2
 new-array v2, v2, [Ljava/lang/String;
 const/4 v3, 0x0
 const-string v4, "_size"
 aput-object v4, v2, v3
 const/4 v3, 0x1
 const-string v4, "date_modified"
 aput-object v4, v2, v3
 const/4 v3, 0x0
 const/4 v4, 0x0
 const/4 v5, 0x0
 invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
 move-result-object v6
 if-eqz v6, :none
 invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z
 move-result v0
 if-eqz v0, :none
 const/4 v0, 0x0
 invoke-interface {v6, v0}, Landroid/database/Cursor;->isNull(I)Z
 move-result v1
 if-nez v1, :none
 invoke-interface {v6, v0}, Landroid/database/Cursor;->getLong(I)J
 move-result-wide v1
 const/4 v0, 0x1
 invoke-interface {v6, v0}, Landroid/database/Cursor;->isNull(I)Z
 move-result v3
 if-nez v3, :none
 invoke-interface {v6, v0}, Landroid/database/Cursor;->getLong(I)J
 move-result-wide v3
 new-instance v0, Ljava/lang/StringBuilder;
 invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
 invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
 const-string v5, ":"
 invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
 invoke-virtual {v0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
 invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
 move-result-object v0
 :try_end
 .catch Ljava/lang/Exception; {:try_start .. :try_end} :failed
 .catchall {:try_start .. :try_end} :fatal
 invoke-static {v6}, Lcom/mrkeyboard/app/MrCopySource;->close(Landroid/database/Cursor;)V
 return-object v0
 :failed
 move-exception v0
 :none
 invoke-static {v6}, Lcom/mrkeyboard/app/MrCopySource;->close(Landroid/database/Cursor;)V
 const/4 v0, 0x0
 return-object v0
 :fatal
 move-exception v0
 invoke-static {v6}, Lcom/mrkeyboard/app/MrCopySource;->close(Landroid/database/Cursor;)V
 throw v0
.end method

.method private static close(Landroid/database/Cursor;)V
 .locals 1
 if-eqz p0, :done
 :try_start
 invoke-interface {p0}, Landroid/database/Cursor;->close()V
 :try_end
 .catch Ljava/lang/Exception; {:try_start .. :try_end} :ignored
 return-void
 :ignored
 move-exception v0
 :done
 return-void
.end method
