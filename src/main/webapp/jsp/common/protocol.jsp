<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:w="urn:schemas-microsoft-com:office:word"
	xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 14">
<meta name=Originator content="Microsoft Word 14">
<title></title>
<!--[if gte mso 9]><xml><w:WordDocument><w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel><w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery><w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery><w:DocumentKind>DocumentNotSpecified</w:DocumentKind><w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing><w:PunctuationKerning></w:PunctuationKerning><w:View>Web</w:View><w:Compatibility><w:DontGrowAutofit/><w:BalanceSingleByteDoubleByteWidth/><w:DoNotExpandShiftReturn/><w:UseFELayout/></w:Compatibility><w:Zoom>0</w:Zoom></w:WordDocument></xml><![endif]-->
<!--[if gte mso 9]><xml><w:LatentStyles DefLockedState="false"  DefUnhideWhenUsed="true"  DefSemiHidden="true"  DefQFormat="false"  DefPriority="99"  LatentStyleCount="260" >
<w:LsdException Locked="false"  Priority="0"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Normal" ></w:LsdException>
<w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="heading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  QFormat="true"  Name="heading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  QFormat="true"  Name="heading 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  QFormat="true"  Name="heading 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  QFormat="true"  Name="heading 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  QFormat="true"  Name="heading 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  QFormat="true"  Name="heading 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  QFormat="true"  Name="heading 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  QFormat="true"  Name="heading 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="39"  SemiHidden="false"  Name="toc 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="39"  SemiHidden="false"  Name="toc 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="39"  SemiHidden="false"  Name="toc 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="39"  SemiHidden="false"  Name="toc 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="39"  SemiHidden="false"  Name="toc 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="39"  SemiHidden="false"  Name="toc 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="39"  SemiHidden="false"  Name="toc 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="39"  SemiHidden="false"  Name="toc 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="39"  SemiHidden="false"  Name="toc 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footer" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="35"  SemiHidden="false"  QFormat="true"  Name="caption" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of figures" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope return" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="line number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="page number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of authorities" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="macro" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toa heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="10"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Title" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Closing" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="1"  SemiHidden="false"  Name="Default Paragraph Font" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Message Header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="11"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Subtitle" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Salutation" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Date" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Note Heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Block Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Hyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="FollowedHyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="22"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Strong" ></w:LsdException>
<w:LsdException Locked="false"  Priority="20"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Emphasis" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Document Map" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Plain Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="E-mail Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal (Web)" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Acronym" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Cite" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Code" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Definition" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Keyboard" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Preformatted" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Sample" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Typewriter" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Variable" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  QFormat="true"  Name="Normal Table" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation subject" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="No List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Contemporary" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Elegant" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Professional" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  QFormat="true"  Name="Balloon Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="59"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Table Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Theme" ></w:LsdException>
<w:LsdException Locked="false"  Priority="60"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="61"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="62"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="63"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="64"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="65"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="66"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="67"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="68"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="69"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="70"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Dark List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="71"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="72"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="73"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="60"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="61"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="62"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="63"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="64"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="65"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="66"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="67"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="68"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="69"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 3 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="70"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Dark List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="71"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="72"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="73"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="60"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="61"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="62"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="63"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="64"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="65"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="66"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="67"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="68"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="69"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 3 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="70"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Dark List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="71"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="72"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="73"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="60"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="61"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="62"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="63"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="64"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="65"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="66"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="67"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="68"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="69"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 3 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="70"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Dark List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="71"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="72"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="73"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="60"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="61"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="62"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="63"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="64"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="65"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="66"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="67"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="68"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="69"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 3 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="70"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Dark List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="71"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="72"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="73"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="60"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="61"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="62"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="63"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="64"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="65"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="66"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="67"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="68"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="69"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 3 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="70"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Dark List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="71"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="72"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="73"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="60"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="61"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="62"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Light Grid Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="63"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="64"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Shading 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="65"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="66"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium List 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="67"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="68"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="69"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Medium Grid 3 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="70"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Dark List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="71"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="72"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="73"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Colorful Grid Accent 6" ></w:LsdException>
</w:LatentStyles></xml><![endif]-->
<style>
@font-face {
	font-family: "Times New Roman";
}

@font-face {
	font-family: "宋体";
}

@font-face {
	font-family: "Calibri";
}

@font-face {
	font-family: "Wingdings";
}

@font-face {
	font-family: "黑体";
}

@
list l0:level1 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%1.";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 41.2500pt;
	text-indent: -18.0000pt;
	font-family: 'Times New Roman';
}

@
list l0:level2 {
	mso-level-number-format: alpha-lower;
	mso-level-suffix: tab;
	mso-level-text: "%2)";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 65.2500pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l0:level3 {
	mso-level-number-format: lower-roman;
	mso-level-suffix: tab;
	mso-level-text: "%3.";
	mso-level-tab-stop: none;
	mso-level-number-position: right;
	margin-left: 86.2500pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l0:level4 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%4.";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 107.2500pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l0:level5 {
	mso-level-number-format: alpha-lower;
	mso-level-suffix: tab;
	mso-level-text: "%5)";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 128.2500pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l0:level6 {
	mso-level-number-format: lower-roman;
	mso-level-suffix: tab;
	mso-level-text: "%6.";
	mso-level-tab-stop: none;
	mso-level-number-position: right;
	margin-left: 149.2500pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l0:level7 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%7.";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 170.2500pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l0:level8 {
	mso-level-number-format: alpha-lower;
	mso-level-suffix: tab;
	mso-level-text: "%8)";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 191.2500pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l0:level9 {
	mso-level-number-format: lower-roman;
	mso-level-suffix: tab;
	mso-level-text: "%9.";
	mso-level-tab-stop: none;
	mso-level-number-position: right;
	margin-left: 212.2500pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l1:level1 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%1.";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 21.0000pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l1:level2 {
	mso-level-number-format: alpha-lower;
	mso-level-suffix: tab;
	mso-level-text: "%2)";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 42.0000pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l1:level3 {
	mso-level-number-format: lower-roman;
	mso-level-suffix: tab;
	mso-level-text: "%3.";
	mso-level-tab-stop: none;
	mso-level-number-position: right;
	margin-left: 63.0000pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l1:level4 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%4.";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 84.0000pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l1:level5 {
	mso-level-number-format: alpha-lower;
	mso-level-suffix: tab;
	mso-level-text: "%5)";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 105.0000pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l1:level6 {
	mso-level-number-format: lower-roman;
	mso-level-suffix: tab;
	mso-level-text: "%6.";
	mso-level-tab-stop: none;
	mso-level-number-position: right;
	margin-left: 126.0000pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l1:level7 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%7.";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 147.0000pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l1:level8 {
	mso-level-number-format: alpha-lower;
	mso-level-suffix: tab;
	mso-level-text: "%8)";
	mso-level-tab-stop: none;
	mso-level-number-position: left;
	margin-left: 168.0000pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

@
list l1:level9 {
	mso-level-number-format: lower-roman;
	mso-level-suffix: tab;
	mso-level-text: "%9.";
	mso-level-tab-stop: none;
	mso-level-number-position: right;
	margin-left: 189.0000pt;
	text-indent: -21.0000pt;
	font-family: 'Times New Roman';
}

p.MsoNormal {
	mso-style-name: 正文;
	mso-style-parent: "";
	margin: 0pt;
	margin-bottom: .0001pt;
	mso-pagination: none;
	text-align: justify;
	text-justify: inter-ideograph;
	font-family: Calibri;
	mso-fareast-font-family: 宋体;
	mso-bidi-font-family: 'Times New Roman';
	font-size: 10.5000pt;
	mso-font-kerning: 1.0000pt;
}

span.10 {
	font-family: Calibri;
}

span.15 {
	font-family: Calibri;
}

span.16 {
	font-family: Calibri;
}

span.17 {
	font-family: Calibri;
	font-size: 9.0000pt;
}

span.18 {
	font-family: Calibri;
	font-size: 9.0000pt;
}

span.19 {
	font-family: Calibri;
	font-size: 9.0000pt;
}

p.MsoFooter {
	mso-style-name: 页脚;
	mso-style-noshow: yes;
	margin: 0pt;
	margin-bottom: .0001pt;
	layout-grid-mode: char;
	mso-pagination: none;
	text-align: left;
	font-family: Calibri;
	mso-fareast-font-family: 宋体;
	mso-bidi-font-family: 'Times New Roman';
	font-size: 9.0000pt;
	mso-font-kerning: 1.0000pt;
}

p.21 {
	mso-style-name: "List Paragraph";
	margin: 0pt;
	margin-bottom: .0001pt;
	text-indent: 21.0000pt;
	mso-char-indent-count: 2.0000;
	mso-pagination: none;
	text-align: justify;
	text-justify: inter-ideograph;
	font-family: Calibri;
	mso-fareast-font-family: 宋体;
	mso-bidi-font-family: 'Times New Roman';
	font-size: 10.5000pt;
	mso-font-kerning: 1.0000pt;
}

p.MsoAcetate {
	mso-style-name: 批注框文本;
	mso-style-noshow: yes;
	margin: 0pt;
	margin-bottom: .0001pt;
	mso-pagination: none;
	text-align: justify;
	text-justify: inter-ideograph;
	font-family: Calibri;
	mso-fareast-font-family: 宋体;
	mso-bidi-font-family: 'Times New Roman';
	font-size: 9.0000pt;
	mso-font-kerning: 1.0000pt;
}

p.MsoHeader {
	mso-style-name: 页眉;
	mso-style-noshow: yes;
	margin: 0pt;
	margin-bottom: .0001pt;
	border-bottom: 1.0000pt solid windowtext;
	mso-border-bottom-alt: 0.7500pt solid windowtext;
	padding: 0pt 0pt 1pt 0pt;
	layout-grid-mode: char;
	mso-pagination: none;
	text-align: center;
	font-family: Calibri;
	mso-fareast-font-family: 宋体;
	mso-bidi-font-family: 'Times New Roman';
	font-size: 9.0000pt;
	mso-font-kerning: 1.0000pt;
}

p.24 {
	mso-style-name: fb;
	margin-top: 5.0000pt;
	margin-bottom: 5.0000pt;
	mso-margin-top-alt: auto;
	mso-margin-bottom-alt: auto;
	mso-pagination: widow-orphan;
	text-align: left;
	font-family: 宋体;
	font-size: 12.0000pt;
}

span.msoIns {
	mso-style-type: export-only;
	mso-style-name: "";
	text-decoration: underline;
	text-underline: single;
	color: blue;
}

span.msoDel {
	mso-style-type: export-only;
	mso-style-name: "";
	text-decoration: line-through;
	color: red;
}

table.MsoNormalTable {
	mso-style-name: 普通表格;
	mso-style-parent: "";
	mso-style-noshow: yes;
	mso-tstyle-rowband-size: 0;
	mso-tstyle-colband-size: 0;
	mso-padding-alt: 0.0000pt 5.4000pt 0.0000pt 5.4000pt;
	mso-para-margin: 0pt;
	mso-para-margin-bottom: .0001pt;
	mso-pagination: widow-orphan;
	font-family: 'Times New Roman';
	font-size: 10.0000pt;
	mso-ansi-language: #0400;
	mso-fareast-language: #0400;
	mso-bidi-language: #0400;
}

table.28 {
	mso-style-name: 浅色底纹1;
	mso-tstyle-rowband-size: 0;
	mso-tstyle-colband-size: 0;
	mso-padding-alt: 0.0000pt 5.4000pt 0.0000pt 5.4000pt;
	mso-border-top-alt: 1.0000pt solid rgb(0, 0, 0);
	mso-border-bottom-alt: 1.0000pt solid rgb(0, 0, 0);
	mso-para-margin: 0pt;
	mso-para-margin-bottom: .0001pt;
	mso-pagination: widow-orphan;
	font-family: 'Times New Roman';
	color: rgb(0, 0, 0);
	font-size: 10.0000pt;
	mso-ansi-language: #0400;
	mso-fareast-language: #0400;
	mso-bidi-language: #0400;
}

table.28FirstRow {
	mso-style-name: 浅色底纹1;
	mso-table-condition: first-row;
	mso-tstyle-border-top: 1.0000pt solid rgb(0, 0, 0);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-bottom: 1.0000pt solid rgb(0, 0, 0);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.28LastRow {
	mso-style-name: 浅色底纹1;
	mso-table-condition: last-row;
	mso-tstyle-border-top: 1.0000pt solid rgb(0, 0, 0);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-bottom: 1.0000pt solid rgb(0, 0, 0);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.28FirstCol {
	mso-style-name: 浅色底纹1;
	mso-table-condition: first-column;
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.28LastCol {
	mso-style-name: 浅色底纹1;
	mso-table-condition: last-column;
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.28OddColumn {
	mso-style-name: 浅色底纹1;
	mso-table-condition: odd-column;
	mso-tstyle-shading: rgb(191, 191, 191);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
}

table.28OddRow {
	mso-style-name: 浅色底纹1;
	mso-table-condition: odd-row;
	mso-tstyle-shading: rgb(191, 191, 191);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
}

table.27 {
	mso-style-name: "浅色底纹 - 强调文字颜色 11";
	mso-tstyle-rowband-size: 0;
	mso-tstyle-colband-size: 0;
	mso-padding-alt: 0.0000pt 5.4000pt 0.0000pt 5.4000pt;
	mso-border-top-alt: 1.0000pt solid rgb(79, 129, 189);
	mso-border-bottom-alt: 1.0000pt solid rgb(79, 129, 189);
	mso-para-margin: 0pt;
	mso-para-margin-bottom: .0001pt;
	mso-pagination: widow-orphan;
	font-family: 'Times New Roman';
	color: rgb(54, 96, 145);
	font-size: 10.0000pt;
	mso-ansi-language: #0400;
	mso-fareast-language: #0400;
	mso-bidi-language: #0400;
}

table.27FirstRow {
	mso-style-name: "浅色底纹 - 强调文字颜色 11";
	mso-table-condition: first-row;
	mso-tstyle-border-top: 1.0000pt solid rgb(79, 129, 189);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-bottom: 1.0000pt solid rgb(79, 129, 189);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.27LastRow {
	mso-style-name: "浅色底纹 - 强调文字颜色 11";
	mso-table-condition: last-row;
	mso-tstyle-border-top: 1.0000pt solid rgb(79, 129, 189);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-bottom: 1.0000pt solid rgb(79, 129, 189);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.27FirstCol {
	mso-style-name: "浅色底纹 - 强调文字颜色 11";
	mso-table-condition: first-column;
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.27LastCol {
	mso-style-name: "浅色底纹 - 强调文字颜色 11";
	mso-table-condition: last-column;
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.27OddColumn {
	mso-style-name: "浅色底纹 - 强调文字颜色 11";
	mso-table-condition: odd-column;
	mso-tstyle-shading: rgb(211, 223, 238);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
}

table.27OddRow {
	mso-style-name: "浅色底纹 - 强调文字颜色 11";
	mso-table-condition: odd-row;
	mso-tstyle-shading: rgb(211, 223, 238);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
}

table.MsoTableLightShadingAccent2 {
	mso-style-name: "浅色底纹 - 强调文字颜色 2";
	mso-tstyle-rowband-size: 0;
	mso-tstyle-colband-size: 0;
	mso-padding-alt: 0.0000pt 5.4000pt 0.0000pt 5.4000pt;
	mso-border-top-alt: 1.0000pt solid rgb(192, 80, 77);
	mso-border-bottom-alt: 1.0000pt solid rgb(192, 80, 77);
	mso-para-margin: 0pt;
	mso-para-margin-bottom: .0001pt;
	mso-pagination: widow-orphan;
	font-family: 'Times New Roman';
	color: rgb(148, 55, 52);
	font-size: 10.0000pt;
	mso-ansi-language: #0400;
	mso-fareast-language: #0400;
	mso-bidi-language: #0400;
}

table.MsoTableLightShadingAccent2FirstRow {
	mso-style-name: "浅色底纹 - 强调文字颜色 2";
	mso-table-condition: first-row;
	mso-tstyle-border-top: 1.0000pt solid rgb(192, 80, 77);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-bottom: 1.0000pt solid rgb(192, 80, 77);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.MsoTableLightShadingAccent2LastRow {
	mso-style-name: "浅色底纹 - 强调文字颜色 2";
	mso-table-condition: last-row;
	mso-tstyle-border-top: 1.0000pt solid rgb(192, 80, 77);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-bottom: 1.0000pt solid rgb(192, 80, 77);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.MsoTableLightShadingAccent2FirstCol {
	mso-style-name: "浅色底纹 - 强调文字颜色 2";
	mso-table-condition: first-column;
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.MsoTableLightShadingAccent2LastCol {
	mso-style-name: "浅色底纹 - 强调文字颜色 2";
	mso-table-condition: last-column;
	font-family: 'Times New Roman';
	font-weight: bold;
}

table.MsoTableLightShadingAccent2OddColumn {
	mso-style-name: "浅色底纹 - 强调文字颜色 2";
	mso-table-condition: odd-column;
	mso-tstyle-shading: rgb(239, 211, 211);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
}

table.MsoTableLightShadingAccent2OddRow {
	mso-style-name: "浅色底纹 - 强调文字颜色 2";
	mso-table-condition: odd-row;
	mso-tstyle-shading: rgb(239, 211, 211);
	mso-tstyle-border-left: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-right: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insideh: 31.8750pt none rgb(255, 255, 255);
	mso-tstyle-border-insidev: 31.8750pt none rgb(255, 255, 255);
}

table.MsoTableGrid {
	mso-style-name: 网格型;
	mso-tstyle-rowband-size: 0;
	mso-tstyle-colband-size: 0;
	mso-padding-alt: 0.0000pt 5.4000pt 0.0000pt 5.4000pt;
	mso-border-top-alt: 0.5000pt solid windowtext;
	mso-border-left-alt: 0.5000pt solid windowtext;
	mso-border-bottom-alt: 0.5000pt solid windowtext;
	mso-border-right-alt: 0.5000pt solid windowtext;
	mso-border-insideh: 0.5000pt solid windowtext;
	mso-border-insidev: 0.5000pt solid windowtext;
	mso-para-margin: 0pt;
	mso-para-margin-bottom: .0001pt;
	mso-pagination: widow-orphan;
	font-family: 'Times New Roman';
	font-size: 10.0000pt;
	mso-ansi-language: #0400;
	mso-fareast-language: #0400;
	mso-bidi-language: #0400;
}

@page {
	mso-page-border-surround-header: no;
	mso-page-border-surround-footer: no;
}

@page Section0 {
	margin-top: 72.0000pt;
	margin-bottom: 72.0000pt;
	margin-left: 90.0000pt;
	margin-right: 90.0000pt;
	size: 595.3000pt 841.9000pt;
	layout-grid: 15.6000pt;
}

div.Section0 {
	page: Section0;
}
</style>
</head>
<body style="tab-interval: 21pt; text-justify-trim: punctuation;">
	<!--StartFragment-->
	<!-- 
	<div class="Section0" style="layout-grid: 15.6000pt;">
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; color: rgb(110, 109, 115); font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员租车协议</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">特别提示：</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">建议</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">您</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">在</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">完成</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">注册之前，仔细阅读本协议。本协议在您接受注册时生效，将成为您和</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">之间具有法律意义的文件，您和</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">将同时受到本协议条款的约束</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">。在您注册成功后，巴歌出行将您注册使用的手机号做为您的会员账号，也是您在巴歌出行平台的身份标识，您将自行设置密码，该账号和密码由您负责保管，您应当对通过您账号进行的所有活动和事件承担法律责任。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行有权随时对本条款内容进行单方面变更，并以在巴歌出行官方公告的方式公布，无需另行单独通知您，若您在本条款内容公告变更后继续使用本服务，表示您已经充分阅读、理解并接受修改后的内容，也将遵循修改后的条款内容使用本服务；若您不同意修改后的条款内容，您应停止使用本服务。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">您同意接受本协议所有条款并注册成为巴歌出行会员，您是具有法律规定的享有完全民事权利能力和民事行为能力，且能够独立承担民事责任的自然人，不具备前述条件的，请立即停止注册或使用本服务。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第一章</font>&nbsp;<font face="黑体">总则</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#8220;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#8221;是指北京</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">汽车租赁有限公司创建的用于提供电动车租赁信息服务的移动互联网技术平台。</font>&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&nbsp;&#8220;用户&#8221;，</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">通过巴歌出行</font>&nbsp;APP或者微信，注册成功，上传证照经审核通过的人</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 30.0000pt; mso-char-indent-count: 2.5000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#8220;会员&#8221;，指</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">服务</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">的</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">使用人。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;北京</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">汽车租赁有限公司（以下简称</font>&#8220;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#8221;）</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">致力于</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">为客户提供安全、</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">便捷</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">的电动车分时租赁服务。为明确会员的权利和义务，特制定本协议。</font>&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第二章</font>&nbsp;<font face="黑体">注册、会员资格及会费</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1.凡年龄在18周岁（含）以上、持有中华人民共和国有效身份证件（二代身份证、港澳居民来往内地通行证、大陆通行证、护照）和中华人民共和国有效驾驶执照（准驾车为C1以上），有一年以上实际驾驶经验均可申请成为用户。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 30.0000pt; mso-char-indent-count: 2.5000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">2.所有&nbsp;&#8220;巴歌出行&#8221;的个人用户，在巴歌账户充值299元会费后，即可成为巴歌出行会员。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#8226;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#9;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&nbsp;3.所有&nbsp;&#8220;巴歌出行&#8221;的企业用户（与巴歌出行签订企业协议的企业员工），一经注册认证成功，即直接成为会员。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">4.如果会员的驾照在任何时间被吊销、没收、失效或状态发生变化，会员必须立即通知巴歌出行，且在此期间会员不得使用巴歌出行的车辆，否则由此产生的后果和责任由会员自行承担。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">5.会员账号的所有权归巴歌出行，用户必须使用本人的有效信息完成注册并通过实名审核认证，才可获得巴歌出行的使用权。会员应提供及时、详尽及准确的个人资料，并不断更新注册资料，符合及时、详尽和准确的要求。所有原始键入的资料将作为注册资料。如果因会员注册信息不真实而引起的一切问题及其产生的后果，巴歌出行不负任何责任，巴歌出行有权对会员账号进行停封措施的权利。如对巴歌出行造成损失，巴歌出行有权追究会员责任及相关损失。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">6.会员不得将其账号、密码转让或出借予他人使用。如会员发现其账号遭他人非法使用，应立即通知巴歌出行。因黑客行为或会员个人的保管疏忽导致账号、密码遭他人非法使用，巴歌出行将不承担任何责任。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">7.&nbsp;如会员账户有欠款或其他待处理事项，包括但不限于违章,，经巴歌出行工作人员提醒，且拒不处理者，巴歌出行有权从会员会费或账户余额中，直接抵扣巴歌出行由此造成的损失。如会员会费和账户余额不足以抵扣该损失，巴歌出行有权向会员追究法律责任。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第三章</font>&nbsp;<font face="黑体">会员的权利及义务</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员享有使用巴歌出行产品和服务的权益。所有会员，短租自驾租车均不限行驶里程（有固定里程限制的产品除外）。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">2.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员资格仅限会员本人使用。会员</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">在租期内有巴歌出行车辆的承租用途的使用权，并承诺</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">持有与准驾车型相符</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">由中国大陆交管部门核发的并按要求审验的《中华人民共和国机动车驾驶证》</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">、</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">并</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">有一年以上驾驶经历。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">3．会员享有自愿入会、自由退会的权力。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">4.如巴歌出行车辆出现故障或异常情况，会员应立即通知巴歌出行，并到巴歌出行指定地点修理或更换，会员不得擅自拆卸、更换原车设备及零件。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">5.巴歌出行提供的车辆只能作为会员自用车辆使用，</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员不得用</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行的</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">车辆进行违法活动，不得参加各类竞赛</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">、</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">作测试</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">、实验和教练</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">使用，不得进行赢利性质的运</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">营</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">，</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员不享有转租、转借、抵押、倒卖或其它任何损害车辆所有权和使用权的行为，巴歌车辆</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">不得运送</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">有毒有害、</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">易燃、易爆、易腐蚀品</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">等违禁物品，会员不得酒后驾驶</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">，不得在坏损或非正式路面上行驶，凡因上述原因造成车辆损坏或公安部门的扣车、对车主罚款等发生的一切费用和损失均由会员承担。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">6.会员还车后</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">由于会员</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">个人</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">原因致使车辆牌照、车钥匙、证件等物品丢失，除支付补办相关物品的全部费用外，还应当支付补办相关物品期间给巴歌出行造成的营业损失</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">，损失费用由会员自行承担，如无故不承担相关费用，相应法律责任由会员承担。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">7.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员自行承担租期内租赁车辆的</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">电费、</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">过路、过桥、停车等费用</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">，自行负责车上人员及财产安全。会员在使用巴歌出行车辆时应当严格遵守道路交通法和管理规则，并独立承担因违章和交通事故产生的相关责任。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">8.由于会员自身原因，如：驾驶习惯、误操作、保管不等对车辆造成损失，应由会员承担相应及由此带来的一切损失，如无故不承担相关费用，相应法律责任由会员承担。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第四章</font>&nbsp;<font face="黑体">会员的权益</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1．一经成为会员，即可获得巴歌出行提供的价值118元优惠券；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">2.&nbsp;可以使用巴歌出行提供的出行服务；&nbsp;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">3．参加巴歌出行组织的各项优惠活动和线下会员活动；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">4．租车违章后，享受免费三小时用车（其中包含20公里免费里程）处理违章特权，超出时长和公里数按正常计费标准计费；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">5．会员生日当天，可获得巴歌出行提供的生日惊喜（可在生日当天拨打巴歌出行客服电话咨询）；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">6.&nbsp;参加巴歌出行会员积分计划，获得积分奖励；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">7.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&nbsp;<font
				face="宋体">参加巴歌出行提供的其他服务。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p>&nbsp;</o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第五章</font>&nbsp;<font face="黑体">会员违约</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p>&nbsp;</o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1.会员在使用巴歌出行服务时，必须遵守中华人民共和国相关法律法规的规定，会员应同意不会利用本服务进行任何违法或不正当的活动，包括但不限于如下行为：</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（1）提供虚假信息，或盗用他人信息的；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（2）未按约定用途使用车辆的；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（3）转卖、抵押、典当、转借、转租或确有证据证明可能存在上述情况时；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（4）不按协议约定交纳租金及各项费用、使用租赁车辆、保管租赁车辆、归还租赁车辆的；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（5）会员利用租赁车辆从事违法犯罪活动的；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（6）擅自改装、更换、增设它物的；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（7）利用任何方式方法危害巴歌出行平台安全的；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（8）利用巴歌出行或其提供的车辆，损害任何第三人合法权益的；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（9）复制、发布含有下列内容信息的：</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">a.&nbsp;危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">b.&nbsp;损害国家荣誉和利益；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;c.&nbsp;煽动民族仇恨、民族歧视，破坏民族团结；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;d.&nbsp;破坏国家宗教政策，宣扬邪教和封建迷信；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;e.&nbsp;散布谣言，扰乱社会秩序，破坏社会稳定；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;f.&nbsp;散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 66.0000pt; mso-char-indent-count: 5.5000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">g.侮辱或者诽谤他人，侵害他人合法权利的；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 66.0000pt; mso-char-indent-count: 5.5000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">h.含有虚假、有害、胁迫、侵害他人隐私、骚扰、侵害、中伤、粗俗、猥亵、或其它道德上令人反感的内容；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">.&nbsp;恶意诋毁巴歌出行的（包括在巴歌出行平台，以及在其他任何地方）；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;j</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">.&nbsp;含有法律、行政法规禁止的其他内容。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">2.因违法违规导致车辆被扣的，或不能上路行驶而导致停运的，自停运之日起，客户需承担停运损失费，计算标准：日租价格*停运天数。如有其它损失或罚款等损失由客户承担。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; background: rgb(255, 255, 255);">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">3.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行为会员提供短租服务，如果会员超过约定还车时间</font>24小时未还车，我司有权将车辆强制收回。车辆因强制执行收回造成的一切责任和费用包括停运费用、车辆损坏费用等，一律由会员自行承担。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">4.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员出现上述违约责任情形巴歌出行解除协议时</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">，在会员不按照巴歌出行要求归还车辆时，巴歌出行有权利用备用的车辆钥匙将租赁车辆取回，对于车辆中的物品巴歌出行有权留置或返还，由此而造成会员损失的，巴歌出行不承担任何赔偿责任。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">同时，巴歌出行有权向会员追责或索赔，此外，巴歌出行有权追究当事人的法律责任。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第六章</font>&nbsp;<font face="黑体">重要服务说明</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1.巴歌出行服务的具体内容由巴歌出行根据实际情况提供，除非本服务协议另有其它明解规定，巴歌出行在会员注册后所推出的新产品、新功能、新服务，均受到本服务协议之规范，巴歌出行对其提供服务拥有最终解释权。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">2.鉴于网络服务的特殊性，巴歌出行享有不经事先通知，随时变更、中断或终止部分或全部网络服务。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">3.巴歌出行需要定期或不定期地对提供网络服务的平台或相关设备进行检修维护或者升级，如因此类情况而造成网络服务（包括收费网络服务）在合理时间内的中断，巴歌出行无需为此承担任何责任。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">4.巴歌出行有权于任何时间暂时或永久修改或终止本服务，而无论其通知与否，巴歌出行对会员和任何第三人均无需承担任何责任。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">5.终止服务，会员同意巴歌出行有权基于其自行之考虑，因任何理由，包含但不限于长时间未使用，或巴歌出行认为会员已经违反本协议的文字及精神，终止会员账号、密码或本服务之使用，并将会员在本服务内任何内容加以移除并删除。会员同意依本协议任何规定提供之本服务，无需进行事先通知即可中断或终止，会员承认并同意，巴歌出行可立即关闭或删除会员账号及会员账号中所有相关信息及文件。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p>&nbsp;</o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="黑体">第七章</font>&nbsp;&nbsp;<font face="黑体">计费规则及取还车说明</font></span><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1.计费规则：</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">租</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">金</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">以</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">时间加里程</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">为计量单位，租期</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">按用户下单并首次开启车门计时和计里程，按每分种</font>N元+每公里N元（N代表按不同车型收取的租车费用单价，详见巴歌官方价格单）</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">收取车辆租金</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">和</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">保险等费用，车辆租金</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">及保险（包含不计免赔）</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">为租车必付费用；可选服务为会员可</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">自行</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">选</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">择</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">的服务，费用另计；</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">可选服务包括：司乘险等</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">2.订车说明：会员可以通过下载手机APP客户端&#8220;巴歌出行&#8221;进行下单订车操作。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">3.取车说明：起租时间按用户实际取车时间计算；用户下单后有15分钟免费等待时间，15分钟内未取车且没有取消订单，巴歌默认为订单有效，系统自动开始计费，用户需支付订单产生费用。同时，在一个自然日内，最多取消三次订单，且不收取任何费用，取消订单超过三次则当日不能再下单租用车辆。取车时，会员应当确认车辆实际状况，如有疑问请致电客服。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">4.用户</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">租车时，请携带有效身份证明（身份证、港澳居民来往内地通行证、大陆通行证、护照）、国内驾驶证、信用卡；</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;（1）证件有效期须至少超过当次租期的一个月以上（非大陆客户两个月以上）；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;（2）港澳台客户或外籍客户，首次租车时须提前一个工作日提交证件扫描件。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">注：巴歌出行采用实名制租车，用户凭本人有效证件（身份证和驾驶证）下单并享受用车服务，不可私自将车辆交由他人驾驶，违规者收取</font>1000元违约金，由此产生包括车辆损失和事故带来的一切后果由租车人全部承担。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">5.还车说明：用户应在巴歌出行规定区域内进行还车操作，当客户端显示还车不成功时，订单仍继续计费，还车时会员需要确认车辆停放在合规停车位并关闭电源及车门，</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">还车时间以</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">用户自助还车并成功还车或</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">车场管理员操作还车完成时间为准</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">，还车后应按</font>APP提示给车辆拍照，以方便下位用户寻找车辆，如会员未按规定还车导致车辆违章或其它车辆损失，及其产生的后果由该订单会员承担。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 30.0000pt; mso-char-indent-count: 2.5000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">a.车辆（连同其钥匙和所有车辆附属物品，包括行驶本、手册、车轮防盗螺母，备胎，充电线，三角牌、灭火器等）必须一并归还，并且要保持和租用期开始前一致的状况，如发生丢失或损坏需照价赔偿，相应产生的停运损失费及其它费用需用车会员一并赔偿。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 30.0000pt; mso-char-indent-count: 2.5000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">b.会员应在车辆归还时，确保车内无任何个人财物。如还车时，有任何会员个人财物遗落车中，所产生的相应责任由会员个人承担，巴歌出行不承担任何责任。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 30.0000pt; mso-char-indent-count: 2.5000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">c.用户有义务保持租赁车辆的清洁，如还车后车内有明显污迹或垃圾，应支付清洁费50元，污损严重者按实际清理费用支付。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第八章</font>&nbsp;<font face="黑体">保险与事故说明</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">租赁期间因车辆事故导致的侵权或违法及其他间接损失由会员自行承担</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">；</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">因超过车辆购置价格</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">50%以上重大事故或全损、报废事故的造成损失客户必须承担20%的车辆购置价格的绝对免赔部分（此项不计入其他条款）</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">2</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行向会员提供的车辆都已投保了交通责任强制险、车损险、盗抢险、第三者责任险（</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">伍</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">拾万元）、玻璃险、划痕险、司乘险，但在保险理赔范围内有绝对的免赔额度</font>1500元</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">，部分</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">需要会员承担</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">（第一条不计入）</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">3.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">客户下单租车</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">后租金中含有不计免赔保险</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">，在理赔额度范围内</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">且保险公司没有拒赔或免赔的情况下，</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">不需要</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">承担费用。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">如车辆出现事故定损额超出车辆投保的各项保险理赔额度或费用，超出部分由会员承担</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">4</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">出险后</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">需要及时的报警报案并联系我公司客服中心。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;会员对于在汽车使用期间发生任何保险理赔的问题，有责任且必须保证全力配合巴歌出行和保险公司的各项理赔及维修工作。&nbsp;未能立即报告事故和配合事故调查及未在保险公司规定时间内定损的，会员承担全部责任和费用。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;会员不得隐瞒租赁期内车辆发生的意外事故。如发生事故，会员应及时通知巴歌出行客服中心，并及时向当地公安机关及保险公司报案，以便巴歌出行协助处理保险理赔事宜。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员承租车辆期间发生交通事故，必须到巴歌出行指定的地点进行修理，在会员有责任的情况下，修理费由会员先行垫付，车辆停驶期间的租金照常计算；会员垫付的费用中保险公司理赔金额，在保险公司赔付款到账后由巴歌出行在</font>30个工作日内返还给会员。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">5.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员承租车辆期间发生</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">盗抢</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">，</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">车辆盗抢灭失时会员应负全部责任和相关损失含车辆本身补办费用及处置运营费用等。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">6.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">在会员有责任的情况下须在事故结案一个月内如实提供事故证明、交通管理部门出具的事故责任认定书、事故调解书、损失清单以及有关修理费用等单据。涉及人员伤亡的，会员应在保险公司规定的期限内提交判决书等相应单据。否则，视为会员自愿放弃索赔权益并承担相关损失。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">7.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">在会员有责任的情况下承担一切保险公司拒绝理赔部分的费用，会员该项赔付义务不因各方合作的终止而灭失。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;若涉及第三方责任，双方应互相协助保险公司追讨应由第三方承担的费用。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">8.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">租赁车辆发生各类机件故障、事故车修复，应当到巴歌出行指定的修理厂进行修理。反之，会员应当支付由此造成的修理费用及（复原）返修费用和返修期间巴歌出行的营业损失（损失以协议日租金为单位计算）由此给巴歌出行或第三方造成其他损失的，会员应予赔偿。</font>&#160;&#160;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">注</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">：</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">无论会员是否购买保险服务，会员在租赁期间发生有责或无责事故需要进厂维修或者丢失证照需要补办等，为巴歌出行造成直接损失和间接损失的，导致车辆无法正常运营的巴歌出行均收取营运损失费用。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">详见下表：如表中无相关项目，以实际损失为准。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="宋体">物品损坏、遗失赔偿表</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<table class=MsoTableGrid
			style="border-collapse: collapse; width: 426.1000pt; mso-table-layout-alt: fixed; mso-padding-alt: 0.0000pt 5.4000pt 0.0000pt 5.4000pt;">
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">项目</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">补办价格（元/个）</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">停运损失费（天）</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">行驶本</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">150</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">2</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">交强险、年检、环保标</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">50</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">无</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">车钥匙</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">按实际价格</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">千斤顶</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">100</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">无</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">故障警示牌</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">100</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">无</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">随车工具</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">200</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">无</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">备胎</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">按实际价格</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">无</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">充电线</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1000</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">无</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">车机OBD设备</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1000</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">按实际维修时间</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=189 valign=top
					style="width: 142.0000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">车贴、内饰及内外部件</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">按实际价格</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=189 valign=top
					style="width: 142.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">按实际维修时间</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
		</table>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">停运损失费计算标准：按定损金额的</font>20%赔付。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行的基本保险简介如下（具体赔偿范围及赔付金额以保险公司条款为准）</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<table class=MsoTableGrid
			style="border-collapse: collapse; width: 426.1000pt; mso-table-layout-alt: fixed; mso-padding-alt: 0.0000pt 5.4000pt 0.0000pt 5.4000pt;">
			<tr>
				<td width=92 valign=top
					style="width: 69.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">保险项目</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">保额</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=151 valign=top
					style="width: 113.4000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">保障范围</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">承租方责任</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=113 valign=top
					style="width: 85.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">保险公司及巴歌出行责任</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=78 valign=top
					style="width: 59.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">备注</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=92 valign=top rowspan=2
					style="width: 69.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">车辆损失</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top rowspan=2
					style="width: 49.6000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">车辆实际价值</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=151 valign=top
					style="width: 113.4000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">保险事故导致车辆本身的损失</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">0</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=113 valign=top
					style="width: 85.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">1000元以上</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=78 valign=top rowspan=2
					style="width: 59.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">保险公司免赔/拒赔部分由用户承担</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=151 valign=top
					style="width: 113.4000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">保险事故导致车辆报废</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">0</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=113 valign=top
					style="width: 85.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">85%</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=92 valign=top
					style="width: 69.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">第三者责任险</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">10-50万</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=151 valign=top
					style="width: 113.4000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">发生意外事故导致第三者承受的损失</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">0</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=113 valign=top
					style="width: 85.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">100%</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=78 valign=top rowspan=3
					style="width: 59.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">超过保额部分由用户承担</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=92 valign=top
					style="width: 69.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">车上人员责任险</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">50万（司乘险）</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=151 valign=top
					style="width: 113.4000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">发生保险事故导致驾驶员或乘客人身死亡</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">0</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=113 valign=top
					style="width: 85.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">100%</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=92 valign=top
					style="width: 69.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">玻璃单独破损险</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">新车原价</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=151 valign=top
					style="width: 113.4000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">玻璃单独破损造成的损失</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">0</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=113 valign=top
					style="width: 85.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">100%</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr>
				<td width=92 valign=top
					style="width: 69.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">自燃损失险</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">按车辆损失</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=151 valign=top
					style="width: 113.4000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">由于自身原因起火燃烧造成的车辆损失</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=66 valign=top
					style="width: 49.6500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">0</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=113 valign=top
					style="width: 85.0500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">100%</span><span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=78 valign=top
					style="width: 59.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
						<span
							style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p>&nbsp;</o:p></span>
					</p></td>
			</tr>
		</table>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">注：</font></span><span
				style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; mso-bidi-font-family: 'Times New Roman'; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><font
				face="宋体">不仅包含上述已说明费用且含未说明已发生的情况，费用以实际发生额作为收取标准，用户同意巴歌有进一步采取各项法律措施声讨收回费用的权利且用户有无条件义务予以配合解决。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="宋体">第九章</font>&nbsp;<font face="宋体">救援服务</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行向租车用户提供</font>7X24小时救援服务，客户遇到紧急情况，可致电24小时客户中心</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=21
			style="margin-bottom: 12.0000pt; margin-left: 21.0000pt; text-indent: -21.0000pt; mso-char-indent-count: 0.0000; mso-pagination: widow-orphan; text-align: left; mso-list: l1 level1 lfo1;">
			<![if !supportLists]>
			<span
				style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><span
				style='mso-list: Ignore;'>1.<span>&nbsp;</span></span></span>
			<![endif]>
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">由于车辆本身故障引起的救援费用由巴歌出行承担。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=21
			style="margin-bottom: 12.0000pt; margin-left: 21.0000pt; text-indent: -21.0000pt; mso-char-indent-count: 0.0000; mso-pagination: widow-orphan; text-align: left; mso-list: l1 level1 lfo1;">
			<![if !supportLists]>
			<span
				style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><span
				style='mso-list: Ignore;'>2.<span>&nbsp;</span></span></span>
			<![endif]>
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">非车辆本身故障导致无法正常行驶的（包含且不限于人为操作失误、保险事故或车辆电量耗尽等）救援费用由客户承担（保险公司承担除外）道路救援费用按实际发生费用为准。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=21
			style="margin-bottom: 12.0000pt; margin-left: 21.0000pt; text-indent: -21.0000pt; mso-char-indent-count: 0.0000; mso-pagination: widow-orphan; text-align: left; mso-list: l1 level1 lfo1;">
			<![if !supportLists]>
			<span
				style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><span
				style='mso-list: Ignore;'>3.<span>&nbsp;</span></span></span>
			<![endif]>
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">除车辆自身故障造成的救援费用均实报实销，客户承担。如车辆无电、车辆轮胎破损、车辆事故、车辆驶出电子围栏等。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=21
			style="margin-bottom: 12.0000pt; margin-left: 21.0000pt; text-indent: -21.0000pt; mso-char-indent-count: 0.0000; mso-pagination: widow-orphan; text-align: left; mso-list: l1 level1 lfo1;">
			<![if !supportLists]>
			<span
				style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><span
				style='mso-list: Ignore;'>4.<span>&nbsp;</span></span></span>
			<![endif]>
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">车辆因强制执行收车造成的一切人工费用和相关经济损失含停驶停运费用、车辆损坏费用等，一律由当时租用此车会员承担一切费用。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p>&nbsp;</o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第十章</font>&nbsp;<font face="黑体">违章说明</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">在用户租期内发生的违章，用户有责任处理，无扣分违章用户可直接将相应罚款支付到巴歌帐户，有扣分违章用户也可由巴歌代为处理并支付相关费用，如用户选择自行处理流程如下：个人中心</font></span><span
				style="mso-spacerun: 'yes'; font-family: Wingdings; mso-ascii-font-family: 宋体; mso-fareast-font-family: 宋体; mso-hansi-font-family: 宋体; mso-bidi-font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#224;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">违章处理</font></span><span
				style="mso-spacerun: 'yes'; font-family: Wingdings; mso-ascii-font-family: 宋体; mso-fareast-font-family: 宋体; mso-hansi-font-family: 宋体; mso-bidi-font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#224;</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">下违章处理预约订单，并需要按时取车处理违章，由此产生的用车费用由用户承担。在各别城市巴歌将收取违章押金，金额</font>1000元，30个工作日后无违章记录即可返还。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; text-indent: 24.0000pt; mso-char-indent-count: 2.0000; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行将短信或微信通知客户租期内的车辆违章，届时请致电</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌客服</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">询问详情。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;违反交通安全法规时，如现场被告知（比如违反规定停放车辆，被贴条等），应在被告知的5日内接受处罚；如非现场被告知，巴歌出行可发出书面通知（包括电子邮件、短信等方式）会员交通违章信息，会员收到通知后，应于两周内自行交纳罚款。如拒绝接受处罚，会员应承担由此给巴歌出行造成的损失。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">违章造成停驶停运的应由用户承担全部费用，因补办行驶证保险单等造成停驶停运的全部停运损失。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第十一章</font>&nbsp;<font face="黑体">知识产权</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;巴歌出行提供的服务中包含的任何文本、图片、图形、音频和/或视频资料均受版权、商标和/或其它财产所有权法律的保护，未经相关权利人同意，上述资料均不得在任何媒体直接或间接发布、播放、出于播放或发布目的而改写或再发行，或者被用于其他任何商业目的。所有这些资料或资料的任何部分仅可作为私人和非商业用途而保存在某台计算机或移动终端内。巴歌出行为提供服务而使用的任何软件（包括但不限于软件中所含的任何图象、照片、动画、录像、录音、音乐、文字和附加程序、随附的帮助材料）的一切权利均属于该软件的著作权人，未经该软件的著作权人许可，用户不得对该软件进行反向工程（reverse&nbsp;engineer）、反向编译（decompile）或反汇编（disassemble）。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第十二章</font>&nbsp;<font face="黑体">隐私保护说明</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;隐私权是您的重要权利。向我们提供您的个人信息是基于对我们的信任，相信我们会以负责的态度对待您的个人信息。我们认为您提供的信息只能用于帮助我们为您提供更好的服务。因此，我们制定了巴歌出行会员个人信息保密制度以保护您的个人信息。巴歌出行的个人信息保密制度摘要如下：</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;保密：</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;通常，您能在匿名的状态下访问我们的平台并获取信息。在我们请求您提供有关信息之前，我们会解释这些信息的用途，我们有些站点需要注册才能加入。在通常情况下，这类注册要求您提供一些诸如您的工作、职务及所使用车辆等一类的基本信息，有时我们也会请您提供更多的信息。我们这样做是为了使我们更好的了解您的需求，以便向您提供更有效的服务。我们收集的信息包括姓名、性别、年龄、有效证件、地址、电话号码等。您有权随时决定不接受来自我们的任何资料。我们将采取合理的措施尽最大可能保护您的个人资料。每当您提供给我们信息时，我们将采取合理的措施保护您的个人资料，我们也将采取合理的安全手段保护已存储的个人资料。除非根据法律或政策的强制性规定，或者未向您提供服务之需要，在未得到您的许可之前，我们不会把您的任何个人资料提供给无关的第三方。但是，如果您要求我们提供特定客户支援服务或把一些物品送交给您，我们则需要把您的姓名和地址提供给第三者。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;隐私权原则：</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;您一旦注册成功成为会员，将得到一个密码和帐号。如果您不保管好自己的帐号和密码安全，将负全部责任。另外，每个会员都要对其帐户中的所有活动和事件负全责。您可随时根据指示改变您的密码以及个人资料。由于您的隐私权对我们而言是相当重要的，因此，公布这份隐私权声明的巴歌出行会根据下列五项原则管理涉及隐私的信息。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;原则1</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;每当巴歌出行需要识别您的身份或与您联络时，会明确的询问所需的资料，即个人资料。一般而言，当您在平台上注册，要求提供特别服务，或是如参加积分奖励等，便会被询问到这项资料。可能的话，巴歌出行会利用一些方法，确认您的个人资料的正确性与时效性。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;原则2</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;如果想要将个人资料用在其他用途上，巴歌出行会提供您如何拒绝这项服务的说明。您可以依照巴歌出行的说明，拒绝这项服务。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;原则3</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;巴歌出行也许会因法律要求公开个人资料：</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;原则4</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;任何时候如果您认为巴歌出行没有遵守这些原则时，请拨打</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌客服</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">电话通知我们，我们会尽一切努力，在合理适当的范围内立即改善这个问题。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;原则5</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;Cookies的用途</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行有时会使用</font>cookies，使您在访问我们的平台时得到更好的服务。Cookies是指一种技术，当使用者访问设有Cookies装置的平台时，本平台的服务器会自动发送Cookies至阁下浏览器内，并储存到您的电脑硬盘内，此Cookies便负责记录日后您访问本网站的各种活动、个人资料、浏览习惯、消费习惯甚至信用记录。运用Cookies技术，本网站能够为您提供更加周到的个性化服务。巴歌出行使用&nbsp;Cookie&nbsp;来帮助您实现您的联机体验的个性化。因此，Cookie的主要用途之一是提供一种节约时间的实用功能。您可以接受或拒绝Cookie。大多数Web浏览器会自动接受Cookie，但您通常可根据自己的需要来修改浏览器的设置以拒绝&nbsp;Cookie。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;免责条款</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;有下列情况之一的，巴歌出行不承担任何法律责任：</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（1）由于您将用户密码告知他人或与他人共享注册帐户，或由于黑客获取了您的账户和密码而导致的任何个人资料泄露及由此造成的损失；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（2）任何由于计算机或移动终端的问题、黑客攻击、病毒侵入或发作、政府管制等造成的暂时性关闭，使网络无法正常运行而造成的个人资料泄露、丢失、被盗用或被窜改；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（3）由于与本平台链接的其他网站或平台所造成的个人资料泄露及由此而导致的任何法律争议和后果；</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（4）因不可抗力而引起的任何后果。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;根据《中华人民共和国宪法》和相关法律法规规定，在保护公民合法言论自由的同时，禁止利用互联网、通讯工具、媒体以及其他方式从事以下行为：</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（1）组织、煽动抗拒、破坏宪法和法律、法规实施的。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（2）捏造或者歪曲事实，散布谣言，妨害社会管理秩序的。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（3）组织、煽动非法集会、游行、示威、扰乱公共场所秩序的。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;&#160;（4）从事其他侵犯国家、社会、集体利益和公民合法权益的。管理部门将依法严加监管上述行为并予以处理；对构成犯罪的，司法机关将追究刑事责任。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;如何更新您已经提供给巴歌出行的个人信息，如果您的地址、职务（职称）、电话或e-mail地址发生变化，您可以按官网公布的联系方式通知巴歌出行，以帮助我们保持您的资料的准确性。您也可以通过登陆www.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">bagechuxing</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">.cn；(巴歌出行免费注册页面的更新会员资料栏)的方式自行更新您的个人信息。巴歌出行欢迎您对这项保密制度给予评论并提出质疑。我们将致力于保护您的个人信息，尽全力保证这些信息的安全。由于网上技术的发展突飞猛进，我们会随时更新我们的信息保密制度。所有的修订将在此站点公布。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;请将与本声明有关的所有评论和质疑发往web@</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">bagechuxing</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">.cn.</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第十三章</font>&nbsp;<font face="黑体">通知的发送</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;巴歌出行通过会员注册时指定的邮箱、指定的手机号码、APP应用软件中通知栏或者微信向会员发送通知。巴歌出行向多数会员发送通知时，可以在网站公告栏上公布该通知，该种通知模式与向会员发送个别通知具有同样的法律效力。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;通知于发送之日视为已送达会员，会员知悉并接受通知之内容。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;会员如有任何事宜需通知巴歌出行，应当通过巴歌出行对外正式公布的通信地址、传真号码、电子邮件地址等联系方式进行联系及送达。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="margin-bottom: 12.0000pt; mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="宋体">第十四章</font>&nbsp;<font face="宋体">协议的终止和解除</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=21
			style="margin-bottom: 12.0000pt; margin-left: 41.2500pt; text-indent: -18.0000pt; mso-char-indent-count: 0.0000; mso-pagination: widow-orphan; text-align: left; mso-list: l0 level1 lfo2;">
			<![if !supportLists]>
			<span
				style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><span
				style='mso-list: Ignore;'>1.<span>&nbsp;</span></span></span>
			<![endif]>
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">会员如需取消会籍，在确认会员账户欠款、违章等相关事宜全部处理完毕后，可拨打巴歌出行客服电话提交退会申请。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=21
			style="margin-bottom: 12.0000pt; margin-left: 41.2500pt; text-indent: -18.0000pt; mso-char-indent-count: 0.0000; mso-pagination: widow-orphan; text-align: left; mso-list: l0 level1 lfo2;">
			<![if !supportLists]>
			<span
				style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><span
				style='mso-list: Ignore;'>2.<span>&nbsp;</span></span></span>
			<![endif]>
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌出行工作人员接到用户退会申请后，尽快确认会员账户的状态。在确认无欠款无违章无其他相关事务后，在</font>15个工作日内，巴歌出行协助会员办理退会事宜，并将会员账户现金余额包括会费（巴歌账户里充值的任意金额包括会费不计息），退还至会员指定银行卡内。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=21
			style="margin-bottom: 12.0000pt; margin-left: 41.2500pt; text-indent: -18.0000pt; mso-char-indent-count: 0.0000; mso-pagination: widow-orphan; text-align: left; mso-list: l0 level1 lfo2;">
			<![if !supportLists]>
			<span
				style="font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><span
				style='mso-list: Ignore;'>3.<span>&nbsp;</span></span></span>
			<![endif]>
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">如会员有本协议所述任意违约条款，巴歌出行有权利终止和解除本协议、直接从会员账户中扣除因用户违约并造成的损失，并取消该会员会员资格。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal
			style="mso-pagination: widow-orphan; text-align: left;">
			<b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
					face="黑体">第十五章</font>&nbsp;<font face="黑体">附则</font></span></b><b><span
				style="mso-spacerun: 'yes'; font-family: 黑体; mso-bidi-font-family: 宋体; font-weight: bold; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span></b>
		</p>
		<p class=MsoNormal>
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;巴歌出行有权随时修改本协议的任何条款，包括会员服务计划的任何规定或终止当年会员服务计划，即使该等修改或终止会影响会员积分或者其他权利。一旦本协议的内容或者会员服务计划发生变动，巴歌出行将会在平台上公布和使用修改之后的协议内容和服务内容，该公布和使用行为视为巴歌出行已经通知会员修改内容。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;如果不同意巴歌出行对本协议相关条款所做的修改，会员有权停止使用服务。如果会员继续使用服务，则视为会员接受巴歌出行对本协议相关条款所做的修改。</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><o:p></o:p></span>
		</p>
		<p class=MsoNormal>
			<span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;如各方就本协议内容或其执行发生任何争议，各方应友好协商解决；协商不成时，可向</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">北京市东城区</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">人民法院提起诉讼。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;">&#160;&#160;本协议由</span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">北京</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">巴歌</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">汽车租赁有限公司</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">制定，</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">并</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><font
				face="宋体">拥有最终解释权。</font></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: 宋体; font-size: 12.0000pt; mso-font-kerning: 0.0000pt;"><br></span><span
				style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; mso-bidi-font-family: 'Times New Roman'; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
		</p>
	</div>
	-->
	<!--EndFragment-->
	<%=ESAPI.encoder().encodeForHTML(String.valueOf(request.getAttribute("name")))%>
</body>
</html>