Option Explicit

'�O���t�@�C���ǂݍ��ݎQ�ƃT�C�g
'http://cloiwan.com/?p=272

Function Include(strFile)
	'strFile�F�ǂݍ���vbs�t�@�C���p�X
	Dim FSO, objWsh, strPath
	Set FSO = Wscript.CreateObject("Scripting.FileSystemObject")
	
	'�O���t�@�C���̓ǂݍ���
	Set objWsh = FSO.OpenTextFile(strFile)
	ExecuteGlobal objWsh.ReadAll()
	objWsh.Close
 
	Set objWsh = Nothing
	Set FSO = Nothing
End Function


Include("clsGetFilenamesByFSO.vbs")	'�N���X�t�@�C���̓ǂݍ���
Include("clsGetFilenameParts.vbs")	'�N���X�t�@�C���̓ǂݍ���


Dim FSO
Dim GF,GFP
Dim aryFilenames
Dim filename
Dim foldername
Dim targetFilename


Set FSO = Wscript.CreateObject("Scripting.FileSystemObject")
Set GF = New clsGetFilenamesByFSO
Set GFP = New clsGetFilenameParts

'����Ώۃt�H���_�ƃt�@�C���p�^�[����ݒ�
GF.setDirectory = "D:\picture"
GF.setPattern = "\.jpg$"

'���s�O�m�F
If Inputbox("�����𑱍s����ꍇ��execute����͂��Ă�������" & vbcrlf & _
			"�����Ώۃt�H���_:" & GF.getDirectory & vbcrlf & _
			"�����Ώۃp�^�[��:" & GF.getPattern) <> "execute" Then
	MsgBox "�����𒆒f���܂�",vbYesNo
	WScript.Quit
End If

'�t�@�C�����擾
aryFilenames = GF.getFilenamesByFSO()

For Each filename In aryFilenames
	'GFP.setDelimiter="/"
	GFP.setFullFilename = filename
	
	'�ʐ^�t�@�C��������yymm���������o��
	foldername = Mid(filename, GF.getDirectoryLen + 7, 4)

	'�ړ���t�H���_�����݂��Ȃ��ꍇ�͍쐬����
	If Not FSO.FolderExists(GF.getDirectory & "\" & foldername) then
		If msgbox(foldername & "�t�H���_���쐬���܂���",vbYesNo) = vbYes Then
			FSO.CreateFolder(GF.getDirectory & "\" & foldername)
		Else
			MsgBox "�����𒆒f���܂�"
			WScript.Quit
		End If
	End if
	
	targetFilename = GFP.getPath & foldername & "\" & GFP.getFilename

	'Select Case msgbox( filename & vbcrlf & targetFilename,vbYesNoCancel)
	'	Case vbYes
			Call FSO.MoveFile(filename,targetFilename)
	'	Case vbNo
	'		'�t�@�C���ړ��������Ɏ��̃t�@�C���Ɉڂ�
	'	Case vbCancel
	'		MsgBox "�����𒆒f���܂�"
	'		WScript.Quit
	'End Select
Next 

Msgbox "�������I�����܂���"
