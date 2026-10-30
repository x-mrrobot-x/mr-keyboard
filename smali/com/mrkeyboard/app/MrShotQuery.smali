.class final Lcom/mrkeyboard/app/MrShotQuery;
.super Ljava/lang/Object;

# API 26+ query arguments. Providers may ignore LIMIT; callers also bound iteration.
.method static query(Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
 .locals 6
 new-instance v0, Landroid/os/Bundle;
 invoke-direct {v0}, Landroid/os/Bundle;-><init>()V
 const-string v1, "android:query-arg-sql-selection"
 invoke-virtual {v0, v1, p3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V
 const-string v1, "android:query-arg-sql-selection-args"
 invoke-virtual {v0, v1, p4}, Landroid/os/Bundle;->putStringArray(Ljava/lang/String;[Ljava/lang/String;)V
 const-string v1, "android:query-arg-sql-sort-order"
 invoke-virtual {v0, v1, p5}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V
 const/16 v2, 0x7d0
 invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;
 move-result-object v3
 const-string v1, "/video/"
 invoke-virtual {v3, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
 move-result v1
 if-eqz v1, :images
 const/16 v2, 0x3c
 goto :limited
 :images
 const-string v1, "/images/"
 invoke-virtual {v3, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
 move-result v1
 if-eqz v1, :limited
 const/16 v2, 0x3e8
 :limited
 const-string v1, "android:query-arg-limit"
 invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V
 const/4 v1, 0x0
 :try_start
 invoke-virtual {p0, p1, p2, v0, v1}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Landroid/os/Bundle;Landroid/os/CancellationSignal;)Landroid/database/Cursor;
 move-result-object v0
 :try_end
 .catch Ljava/lang/IllegalArgumentException; {:try_start .. :try_end} :fallback
 .catch Ljava/lang/UnsupportedOperationException; {:try_start .. :try_end} :fallback
 goto :checked
 :fallback
 move-exception v0
 invoke-virtual/range {p0 .. p5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
 move-result-object v0
 :checked
 if-nez v0, :done
 new-instance v0, Ljava/lang/IllegalStateException;
 const-string v1, "MediaStore returned a null cursor"
 invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V
 throw v0
 :done
 return-object v0
.end method
