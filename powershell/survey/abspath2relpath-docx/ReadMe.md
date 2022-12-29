# docx のファイル挿入リンクと IncludePicture の違いを調査

doc 形式から docx 形式に word ファイルを変換すると、ファイル挿入リンクが絶対パスになってしまう問題があります。  
ファイル挿入リンクが大量にある場合に、IncludePicuture(ドキュメント保存無し) への置き換えを自動化したいですが、その前に実現方法を調べます。

---

まずは、ファイル挿入リンクだけを使ったファイルと  
IncludePicture だけを使ったファイルを作成します。

![1](https://user-images.githubusercontent.com/49807271/207981565-156cf119-0a39-437d-aa1d-8e41d95f7c20.png)

### ■ 差異確認

[ファイル構成]  
解凍ファイルの構成に差異はありませんでした。  
ただし、ファイル内容に差異があります。

```
C:.
│  1.docx
│  [Content_Types].xml
│
├─docProps
│      app.xml(差異あり)
│      core.xml(差異あり)
│
├─word
│  │  document.xml(差異あり)
│  │  fontTable.xml
│  │  settings.xml(差異あり)
│  │  styles.xml
│  │  webSettings.xml
│  │
│  ├─theme
│  │      theme1.xml
│  │
│  └─_rels
│          document.xml.rels(差異あり)
│
└─_rels
        .rels
```

これらのファイルに関して、差異を確認していきます。

■docProps/app.xml  
[絶対パス]

```XML
<TotalTime>2</TotalTime>
<Words>0</Words>
<Characters>3</Characters>
<CharactersWithSpaces>3</CharactersWithSpaces>
```

[相対パス]

```XML
<TotalTime>3</TotalTime>
<Words>18</Words>
<Characters>106</Characters>
<CharactersWithSpaces>123</CharactersWithSpaces>
```

■docProps/core.xml

[絶対パス]

```XML
<cp:revision>5</cp:revision>
<dcterms:created xsi:type="dcterms:W3CDTF">2022-12-15T13:55:00Z</dcterms:created>
<dcterms:modified xsi:type="dcterms:W3CDTF">2022-12-15T23:10:00Z</dcterms:modified>
```

[相対パス]

```XML
<cp:revision>7</cp:revision>
<dcterms:created xsi:type="dcterms:W3CDTF">2022-12-15T13:56:00Z</dcterms:created>
<dcterms:modified xsi:type="dcterms:W3CDTF">2022-12-15T23:09:00Z</dcterms:modified>
```

■word/document.xml  
[絶対パス]

```XML
        <w:p w14:paraId="36BE9B94" w14:textId="5252AC7D" w:rsidR="00372169" w:rsidRDefault="000901D0">
            <w:bookmarkStart w:id="0" w:name="_GoBack"/>
            <w:bookmarkEnd w:id="0"/>
            <w:r>
                <w:rPr>
                    <w:noProof/>
                </w:rPr>
                <w:drawing>
                    <wp:inline distT="0" distB="0" distL="0" distR="0" wp14:anchorId="48B00603" wp14:editId="3A2BAF6F">
                        <wp:extent cx="1950720" cy="1298448"/>
                        <wp:effectExtent l="0" t="0" r="0" b="0"/>
                        <wp:docPr id="4" name="A.jpg"/>
                        <wp:cNvGraphicFramePr>
                            <a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1"/>
                        </wp:cNvGraphicFramePr>
                        <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
                            <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
                                <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
                                    <pic:nvPicPr>
                                        <pic:cNvPr id="4" name="A.jpg"/>
                                        <pic:cNvPicPr/>
                                    </pic:nvPicPr>
                                    <pic:blipFill>
                                        <a:blip r:link="rId4"/>
                                        <a:stretch>
                                            <a:fillRect/>
                                        </a:stretch>
                                    </pic:blipFill>
                                    <pic:spPr>
                                        <a:xfrm>
                                            <a:off x="0" y="0"/>
                                            <a:ext cx="1950720" cy="1298448"/>
                                        </a:xfrm>
                                        <a:prstGeom prst="rect">
                                            <a:avLst/>
                                        </a:prstGeom>
                                    </pic:spPr>
                                </pic:pic>
                            </a:graphicData>
                        </a:graphic>
                    </wp:inline>
                </w:drawing>
            </w:r>
        </w:p>
        <w:p w14:paraId="2DC82EA5" w14:textId="1983324E" w:rsidR="000901D0" w:rsidRDefault="000901D0">
            <w:r>
                <w:rPr>
                    <w:rFonts w:hint="eastAsia"/>
                    <w:noProof/>
                </w:rPr>
                <w:drawing>
                    <wp:inline distT="0" distB="0" distL="0" distR="0" wp14:anchorId="592D9F7E" wp14:editId="2189AFD8">
                        <wp:extent cx="1950720" cy="1298448"/>
                        <wp:effectExtent l="0" t="0" r="0" b="0"/>
                        <wp:docPr id="3" name="B.jpg"/>
                        <wp:cNvGraphicFramePr>
                            <a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1"/>
                        </wp:cNvGraphicFramePr>
                        <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
                            <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
                                <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
                                    <pic:nvPicPr>
                                        <pic:cNvPr id="3" name="B.jpg"/>
                                        <pic:cNvPicPr/>
                                    </pic:nvPicPr>
                                    <pic:blipFill>
                                        <a:blip r:link="rId5"/>
                                        <a:stretch>
                                            <a:fillRect/>
                                        </a:stretch>
                                    </pic:blipFill>
                                    <pic:spPr>
                                        <a:xfrm>
                                            <a:off x="0" y="0"/>
                                            <a:ext cx="1950720" cy="1298448"/>
                                        </a:xfrm>
                                        <a:prstGeom prst="rect">
                                            <a:avLst/>
                                        </a:prstGeom>
                                    </pic:spPr>
                                </pic:pic>
                            </a:graphicData>
                        </a:graphic>
                    </wp:inline>
                </w:drawing>
            </w:r>
        </w:p>
        <w:sectPr w:rsidR="000901D0">
```

[相対パス]

```XML
        <w:bookmarkStart w:id="0" w:name="_GoBack"/>
        <w:bookmarkEnd w:id="0"/>
        <w:p w14:paraId="4EF2D51C" w14:textId="4901F326" w:rsidR="00372169" w:rsidRDefault="00744CEC">
            <w:r>
                <w:fldChar w:fldCharType="begin"/>
            </w:r>
            <w:r>
                <w:instrText xml:space="preserve"> INCLUDEPICTURE ../../images/A.jpg \d \* MERGEFORMATINET </w:instrText>
            </w:r>
            <w:r>
                <w:fldChar w:fldCharType="separate"/>
            </w:r>
            <w:r>
                <w:pict w14:anchorId="0472F3DC">
                    <v:shapetype id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
                        <v:stroke joinstyle="miter"/>
                        <v:formulas>
                            <v:f eqn="if lineDrawn pixelLineWidth 0"/>
                            <v:f eqn="sum @0 1 0"/>
                            <v:f eqn="sum 0 0 @1"/>
                            <v:f eqn="prod @2 1 2"/>
                            <v:f eqn="prod @3 21600 pixelWidth"/>
                            <v:f eqn="prod @3 21600 pixelHeight"/>
                            <v:f eqn="sum @0 0 1"/>
                            <v:f eqn="prod @6 1 2"/>
                            <v:f eqn="prod @7 21600 pixelWidth"/>
                            <v:f eqn="sum @8 21600 0"/>
                            <v:f eqn="prod @7 21600 pixelHeight"/>
                            <v:f eqn="sum @10 21600 0"/>
                        </v:formulas>
                        <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
                        <o:lock v:ext="edit" aspectratio="t"/>
                    </v:shapetype>
                    <v:shape id="_x0000_i1030" type="#_x0000_t75" style="width:153.75pt;height:102pt">
                        <v:imagedata r:id="rId4"/>
                    </v:shape>
                </w:pict>
            </w:r>
            <w:r>
                <w:fldChar w:fldCharType="end"/>
            </w:r>
        </w:p>
        <w:p w14:paraId="559982F2" w14:textId="10D3B448" w:rsidR="006E5825" w:rsidRDefault="00744CEC">
            <w:r>
                <w:fldChar w:fldCharType="begin"/>
            </w:r>
            <w:r>
                <w:instrText xml:space="preserve"> INCLUDEPICTURE ../../images/B.jpg \d \* MERGEFORMATINET </w:instrText>
            </w:r>
            <w:r>
                <w:fldChar w:fldCharType="separate"/>
            </w:r>
            <w:r>
                <w:pict w14:anchorId="177223CA">
                    <v:shape id="_x0000_i1029" type="#_x0000_t75" style="width:153.75pt;height:102pt">
                        <v:imagedata r:id="rId5"/>
                    </v:shape>
                </w:pict>
            </w:r>
            <w:r>
                <w:fldChar w:fldCharType="end"/>
            </w:r>
        </w:p>
        <w:sectPr w:rsidR="006E5825">
```

調査の結果、自動変換は中々苦労しそうなので、ここらへんで打ち切ります。。。
