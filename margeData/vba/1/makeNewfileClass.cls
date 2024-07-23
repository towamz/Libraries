Private Const CONTROL_SHEET_NAME As String = "�ݒ�"

Private DATA_SHEET_NAME As String
Private SAVE_DIRECTORY As String
Private FILENAME As String

Private Sub Class_Initialize()

    DATA_SHEET_NAME = Worksheets(CONTROL_SHEET_NAME).Range("B3").Value
    
    '�ۑ��f�B���N�g���A\�ŏI����ĂȂ��ꍇ�͕t������
    If Right(Worksheets(CONTROL_SHEET_NAME).Range("B7").Value, 1) <> "\" Then
        Worksheets(CONTROL_SHEET_NAME).Range("B7").Value = Worksheets(CONTROL_SHEET_NAME).Range("B7").Value & "\"
    End If

    SAVE_DIRECTORY = Worksheets(CONTROL_SHEET_NAME).Range("B7").Value
    
    FILENAME = Worksheets(CONTROL_SHEET_NAME).Range("B13").Value & Format(Now(), "mmdd") & ".xlsx"

End Sub





Public Function makeNewfile() As Boolean

    On Error Resume Next
    Sheets(DATA_SHEET_NAME).Select

    If Err.Number <> 0 Then
        MsgBox "�}�[�W�����s����Ă��܂���", vbOKOnly + vbExclamation
        makeNewfile = False
        Exit Function
    End If


    '�ЂȌ`�V�[�g��V�K�u�b�N�ɃR�s�[
    Sheets(DATA_SHEET_NAME).Copy
    
    '�w��t�H���_�ɕۑ�����
    ActiveWorkbook.SaveAs FILENAME:=SAVE_DIRECTORY & FILENAME


End Function