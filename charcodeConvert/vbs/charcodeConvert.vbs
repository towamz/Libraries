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



Include("clsGetFilenameParts.vbs")	'�N���X�t�@�C���̓ǂݍ���
Include("clsGetFilenamesByDir.vbs")	'�N���X�t�@�C���̓ǂݍ���

'�ϐ��錾
Dim objInput,objOutput
Dim objGetFilenameParts, objGetFilenamesByDir
Dim aryFilenames, filename, newFullFilename
Dim tmpStr


'���s�m�F
If MsgBox("Shift_JIS����UTF-8�ɕϊ����܂���?", vbQuestion + vbYesNo, "���s�m�F") = vbNo Then
	WScript.Quit
End If



'�ϊ��Ώۃt�@�C���擾
Set objGetFilenamesByDir = New clsGetFilenamesByDir

objGetFilenamesByDir.setDirectory = "C:\sampleMacro\2209charcode\"
objGetFilenamesByDir.setPattern = ".*\.txt"

aryFilenames = objGetFilenamesByDir.getFilenamesByDir()



'�ϊ����s
Set objGetFilenameParts = New clsGetFilenameParts
Set objInput = CreateObject("ADODB.Stream")
Set objOutput = CreateObject("ADODB.Stream")


For Each filename In aryFilenames

	' �����R�[�h�ϊ���̃t�@�C�������擾
	objGetFilenameParts.setFullFilename = filename
	newFullFilename = objGetFilenameParts.getPath & "convFiles\" & objGetFilenameParts.getFilename
	
	Select Case MsgBox(filename & vbcrlf &"-->" & vbcrlf & newFullFilename, vbQuestion + vbYesNoCancel, "���s�m�F")
		Case vbYes
			'Shift_JIS�`���Ńt�@�C�����J���āA�ꎞ�ϐ��֊i�[����
			objInput.Charset = "Shift_JIS"
			objInput.Open
			objInput.LoadFromFile filename
			tmpStr = objInput.ReadText
			objInput.Close

			'�ꎞ�ϐ����AUTF-8�`���Ńt�@�C���ɏ�������
			objOutput.Charset = "UTF-8"
			objOutput.Open
			objOutput.WriteText tmpStr
			objOutput.SaveTofile newFullFilename , 1	'1=�����t�@�C��������ꍇ�ۑ����Ȃ��B2=�����t�@�C��������ꍇ�㏑�� 'https://ray88.hatenablog.com/entry/2021/09/19/094953
			objOutput.Close		
		
		Case vbNo
			'�������Ȃ��Ŏ��̃t�@�C����
	
		Case vbCancel
			msgbox "���イ��"
			WScript.Quit

	End Select

Next




