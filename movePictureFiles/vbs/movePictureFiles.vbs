Option Explicit

'�O���t�@�C���ǂݍ��ݎQ�ƃT�C�g
'http://cloiwan.com/?p=272

Function Include(strFile)
	'strFile�F�ǂݍ���vbs�t�@�C���p�X
 
	Dim objFso, objWsh, strPath
	Set objFso = Wscript.CreateObject("Scripting.FileSystemObject")
	
	'�O���t�@�C���̓ǂݍ���
	Set objWsh = objFso.OpenTextFile(strFile)
	ExecuteGlobal objWsh.ReadAll()
	objWsh.Close
 
	Set objWsh = Nothing
	Set objFso = Nothing
 
End Function


Include("clsGetFilenamesByFSO.vbs")	'�N���X�t�@�C���̓ǂݍ���
Include("clsGetFilenameParts.vbs")	'�N���X�t�@�C���̓ǂݍ���


Dim objFso
Dim objGetFilenames,objGetFilenameParts
Dim aryFilenames
Dim filename
Dim foldername
Dim targetFilename



Set objFso = Wscript.CreateObject("Scripting.FileSystemObject")
Set objGetFilenames = New clsGetFilenamesByFSO
Set objGetFilenameParts = New clsGetFilenameParts

'����Ώۃt�H���_�ƃt�@�C���p�^�[����ݒ�
objGetFilenames.setDirectory = "C:\pictureFolder\"
objGetFilenames.setPattern = ".*"

'���s�O�m�F
If Inputbox("�����𑱍s����ꍇ��execute����͂��Ă�������" & vbcrlf & _
			"�����Ώۃt�H���_:" & objGetFilenames.getDirectory & vbcrlf & _
			"�����Ώۃp�^�[��:" & objGetFilenames.getPattern) <> "execute" Then
	MsgBox "�����𒆒f���܂�"
	WScript.Quit
End If

'�t�@�C�����擾
aryFilenames = objGetFilenames.getFilenamesByFSO()


For Each filename In aryFilenames
	'objGetFilenameParts.setDelimiter="/"
	objGetFilenameParts.setFullFilename = filename
	
	'�ʐ^�t�@�C��������yymm���������o��
	foldername = Mid(filename, objGetFilenames.getDirectoryLen + 6, 4)

	'�ړ���t�H���_�����݂��Ȃ��ꍇ�͍쐬����
	If Not objFso.FolderExists(objGetFilenames.getDirectory & foldername) then
	
		If msgbox(foldername & "�t�H���_���쐬���܂���",vbYesNo) = vbYes Then
			objFSO.CreateFolder(objGetFilenames.getDirectory & foldername)
		Else
			MsgBox "�����𒆒f���܂�"
			WScript.Quit
			
		End If

	End if
	
	
	targetFilename = objGetFilenameParts.getPath & foldername & "\" & objGetFilenameParts.getFilename

	'Select Case msgbox( filename & vbcrlf & targetFilename,vbYesNoCancel)
	'	Case vbYes
			Call objFSO.MoveFile(filename,targetFilename)
	'	Case vbNo
	'		'�t�@�C���ړ��������Ɏ��̃t�@�C���Ɉڂ�
	'	Case vbCancel
	'		MsgBox "�����𒆒f���܂�"
	'		WScript.Quit
	'End Select

Next 

Msgbox "�������I�����܂���"








