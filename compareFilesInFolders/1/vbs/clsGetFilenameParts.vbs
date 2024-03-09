Class clsGetFilenameParts
	'�t���p�X�ۑ��p�v���p�e�B
	Private STR_FullFilename 
	Private STR_Delimiter

    Private Sub Class_Initialize()
	    '�f���~�^�̊���l��"\"(windows�p�X)
	    STR_Delimiter = "\"
    End Sub
    
    '�f���~�^��ݒ肷��
    Public Property Let setDelimiter(argDelimiter)

    	STR_Delimiter = argDelimiter

	End Property
    
    
	'�t���p�X��ݒ肷��
	Public Property Let setFullFilename(argFullFilename)

	    STR_FullFilename = argFullFilename

	End Property

	'�t���p�X�擾
	Public Property Get getFullFilename()

	    If STR_FullFilename = "" Then
	        Err.Raise 1000, , "�t���p�X���ݒ肳��Ă��܂���"
	    End If

	    getFullFilename = STR_FullFilename
	    
	End Property

	'�p�X�擾
	Public Property Get getPath()

	    If STR_FullFilename = "" Then
	        Err.Raise 1000, , "�t���p�X���ݒ肳��Ă��܂���"
	    End If

	    getPath = Left(STR_FullFilename, InStrRev(STR_FullFilename, STR_Delimiter))
	    
	End Property

	'�t�@�C�����擾
	Public Property Get getFilename()

	    If STR_FullFilename = "" Then
	        Err.Raise 1000, , "�t���p�X���ݒ肳��Ă��܂���"
	    End If

	    getFilename = Mid(STR_FullFilename, InStrRev(STR_FullFilename, STR_Delimiter) + 1)
	    
	End Property

	'�t�@�C����(�g���q�Ȃ�)�擾
	Public Property Get getFilenameNoExt()
	    Dim strFilename 

	    strFilename = getFilename
	    
	    getFilenameNoExt = Left(strFilename, InStrRev(strFilename, ".") - 1)
	    
	End Property

	'�g���q�擾
	Public Property Get getExtension()
	    Dim strFilename 

	    strFilename = getFilename
	    
	    getExtension = Mid(strFilename, InStrRev(strFilename, ".") + 1)
	    
	End Property
End Class