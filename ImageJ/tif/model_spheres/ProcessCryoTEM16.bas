Attribute VB_Name = "Module1"
Sub ProcessCryoTEM16()
Attribute ProcessCryoTEM16.VB_Description = "Macro recorded 10/1/98 by John Minter"
Attribute ProcessCryoTEM16.VB_ProcData.VB_Invoke_Func = " \n14"
'
' ProcessCryoTEM Macro
' Macro recorded 10/1/98 by John Minter
' Note: need to add reference to the follwing file from
' The Tools:Reference menu:
' C:\Program Files\Microsoft Office\Library\Solver\Solver.xla
'
'
    Dim OldActive As Object
    Dim MyWork As Object
    Dim MyName As String
    ChDir "C:\tmp"
    Call GetEIAHeaderFile(HeaderFileName)
    Workbooks.OpenText FileName:=HeaderFileName, Origin:=xlWindows, _
        StartRow:=1, DataType:=xlFixedWidth, FieldInfo:=Array(Array(0, 2), Array(34 _
        , 2), Array(43, 1))
    ActiveSheet.Name = "Header"
    Columns("A:A").Select
    Selection.Columns.AutoFit
    Columns("B:B").Select
    Selection.Columns.AutoFit
    Columns("C:C").Select
    Selection.Columns.AutoFit
    Set OldActive = ActiveSheet
    Call GetEIAResultFile(ResultFileName)
    Workbooks.OpenText FileName:=ResultFileName, Origin:=xlWindows, _
        StartRow:=2, DataType:=xlFixedWidth, FieldInfo:=Array(Array(0, 1), Array(10 _
        , 1), Array(21, 1), Array(32, 1), Array(44, 1), Array(54, 1))
    ActiveSheet.Name = "Data"
    Selection.EntireRow.Insert
    Range("A1").Select
    ActiveCell.FormulaR1C1 = "ln(D)"
    Range("B1").Select
    ActiveCell.FormulaR1C1 = "Neff"
    Range("B1").Select
    ActiveCell.FormulaR1C1 = "J=0 Data"
    Range("C1").Select
    ActiveCell.FormulaR1C1 = "J=2 Data"
    Range("D1").Select
    ActiveCell.FormulaR1C1 = "J=3 Data"
    Range("E1").Select
    ActiveCell.FormulaR1C1 = "J=5.5 Data"
    Columns("B:B").Select
    Selection.Insert Shift:=xlToRight
    Range("B1").Select
    ActiveCell.FormulaR1C1 = "D"
    Range("B2").Select
    ActiveCell.FormulaR1C1 = "=EXP(RC[-1])"
    Range("B2").Select
    Selection.AutoFill Destination:=Range("B2:B29")
    Range("B1").Select
    ActiveCell.FormulaR1C1 = "D [nm]"
    Range("A1:F1").Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlBottom
        .WrapText = False
        .Orientation = 0
        .ShrinkToFit = False
        .MergeCells = False
    End With
    Call GetEIASpreadsheetName(SpreadFile)
    ActiveWorkbook.SaveAs FileName:=SpreadFile, FileFormat:= _
        xlNormal, Password:="", WriteResPassword:="", ReadOnlyRecommended:=False _
        , CreateBackup:=False
    Sheets("Data").Activate
    Set MyWork = ActiveSheet
    MyName = ActiveWorkbook.Name
    OldActive.Activate
    Sheets("Header").Move Before:=Workbooks(MyName).Sheets(1)
    ActiveWorkbook.Save
    Sheets("Data").Select
    ActiveWindow.ScrollRow = 62
    ActiveWindow.SmallScroll Down:=-61
    Columns("A:A").Select
    Selection.NumberFormat = "0.000000"
    Columns("D:D").Select
    Selection.Insert Shift:=xlToRight
    Selection.Insert Shift:=xlToRight
    Columns("G:G").Select
    Selection.Insert Shift:=xlToRight
    Selection.Insert Shift:=xlToRight
    Columns("J:J").Select
    Selection.Insert Shift:=xlToRight
    Selection.Insert Shift:=xlToRight
    ActiveWindow.SmallScroll Down:=67
    ActiveWindow.ScrollRow = 1
    Sheets.Add
    Sheets("Sheet1").Select
    Sheets("Sheet1").Name = "Fit Information"
    ActiveCell.FormulaR1C1 = "J=0"
    Range("C1").Select
    ActiveCell.FormulaR1C1 = "J=2"
    Range("E1").Select
    ActiveCell.FormulaR1C1 = "J=3"
    Range("G1").Select
    ActiveCell.FormulaR1C1 = "J=5.5"
    Range("A2").Select
    ActiveCell.FormulaR1C1 = "GMDJ0"
    Range("A3").Select
    ActiveCell.FormulaR1C1 = "GSDJ0"
    Range("A4").Select
    ActiveCell.FormulaR1C1 = "htJ0"
    Range("C2").Select
    ActiveCell.FormulaR1C1 = "GMDJ2"
    Range("C3").Select
    ActiveCell.FormulaR1C1 = "GSDJ2"
    Range("C4").Select
    ActiveCell.FormulaR1C1 = "htJ2"
    Range("E2").Select
    ActiveCell.FormulaR1C1 = "GMDJ3"
    Range("E3").Select
    ActiveCell.FormulaR1C1 = "GSDJ3"
    Range("E4").Select
    ActiveCell.FormulaR1C1 = "htJ3"
    Range("G2").Select
    ActiveCell.FormulaR1C1 = "GMDJ55"
    Range("G3").Select
    ActiveCell.FormulaR1C1 = "GSDJ55"
    Range("G4").Select
    ActiveCell.FormulaR1C1 = "htJ55"
    Range("A5").Select
    ActiveCell.FormulaR1C1 = "SuR2J0"
    Range("C5").Select
    ActiveCell.FormulaR1C1 = "SuR2J2"
    Range("E5").Select
    ActiveCell.FormulaR1C1 = "SuR2J3"
    Range("G5").Select
    ActiveCell.FormulaR1C1 = "SuR2J55"
    Range("B2").Select
    ActiveWorkbook.Names.Add Name:="GMDJ0", RefersToR1C1:= _
        "='Fit Information'!R2C2"
    Range("B3").Select
    ActiveWorkbook.Names.Add Name:="GSDJ0", RefersToR1C1:= _
        "='Fit Information'!R3C2"
    Range("B4").Select
    ActiveWorkbook.Names.Add Name:="htJ0", RefersToR1C1:= _
        "='Fit Information'!R4C2"
    Range("D2").Select
    ActiveWorkbook.Names.Add Name:="GMDJ2", RefersToR1C1:= _
        "='Fit Information'!R2C4"
    Range("D3").Select
    ActiveWorkbook.Names.Add Name:="GSDJ2", RefersToR1C1:= _
        "='Fit Information'!R3C4"
    Range("D4").Select
    ActiveWorkbook.Names.Add Name:="htJ2", RefersToR1C1:= _
        "='Fit Information'!R4C4"
    Range("F2").Select
    ActiveWorkbook.Names.Add Name:="GMDJ3", RefersToR1C1:= _
        "='Fit Information'!R2C6"
    Range("F3").Select
    ActiveWorkbook.Names.Add Name:="GSDJ3", RefersToR1C1:= _
        "='Fit Information'!R3C6"
    Range("F4").Select
    ActiveWorkbook.Names.Add Name:="htJ3", RefersToR1C1:= _
        "='Fit Information'!R4C6"
    Range("H2").Select
    ActiveWorkbook.Names.Add Name:="GMDJ55", RefersToR1C1:= _
        "='Fit Information'!R2C8"
    Range("H3").Select
    ActiveWorkbook.Names.Add Name:="GSDJ55", RefersToR1C1:= _
        "='Fit Information'!R3C8"
    Range("H4").Select
    ActiveWorkbook.Names.Add Name:="htJ55", RefersToR1C1:= _
        "='Fit Information'!R4C8"
    Sheets("Data").Select
    Range("D1").Select
    ActiveCell.FormulaR1C1 = "J=0 Model"
    Range("E1").Select
    ActiveCell.FormulaR1C1 = "J=0 Res"
    Range("G1").Select
    ActiveCell.FormulaR1C1 = "J=2 Model"
    Range("H1").Select
    ActiveCell.FormulaR1C1 = "J=2 Res"
    Range("J1").Select
    ActiveCell.FormulaR1C1 = "J=3 Model"
    Range("K1").Select
    ActiveCell.FormulaR1C1 = "J=3 Res"
    Range("M1").Select
    ActiveCell.FormulaR1C1 = "J=5.5 Model"
    Range("N1").Select
    ActiveCell.FormulaR1C1 = "J=5.5 Res"
        Sheets("Header").Select
    Range("C17").Select
    Selection.Copy
    Sheets("Fit Information").Select
    Range("B2").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Sheets("Header").Select
    Range("C18").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets("Fit Information").Select
    Range("B3").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Range("D2").Select
    Sheets("Header").Select
    Range("C20").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets("Fit Information").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Sheets("Header").Select
    Range("C19").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets("Fit Information").Select
    Range("D2").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Sheets("Header").Select
    Range("C20").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets("Fit Information").Select
    Range("D3").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Sheets("Header").Select
    Range("C21").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets("Fit Information").Select
    Range("F2").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Sheets("Header").Select
    Range("C22").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets("Fit Information").Select
    Range("F3").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Sheets("Header").Select
    Range("C23").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets("Fit Information").Select
    Range("H2").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Sheets("Header").Select
    Range("C24").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets("Fit Information").Select
    Range("H3").Select
    Selection.PasteSpecial Paste:=xlAll, Operation:=xlNone, SkipBlanks:=False _
        , Transpose:=False
    Range("A7").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "dataMax"
    Range("B7").Select
    ActiveCell.FormulaR1C1 = "=MAX(Data!R[-5]C[1]:R[1124]C[1])"
    Range("D7").Select
    ActiveCell.FormulaR1C1 = "=MAX(Data!R[-5]C[2]:R[1124]C[2])"
    Range("F7").Select
    ActiveCell.FormulaR1C1 = "=MAX(Data!R[-5]C[3]:R[1124]C[3])"
    Range("H7").Select
    ActiveCell.FormulaR1C1 = "=MAX(Data!R[-5]C[4]:R[1124]C[4])"
    Range("B7").Select
    Selection.Copy
    Range("B4").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Range("D7").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("D4").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Range("F7").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("F4").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Range("H7").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("H4").Select
    Selection.PasteSpecial Paste:=xlValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=False
    Sheets("Data").Select
    Range("D2").Select
    ActiveCell.FormulaR1C1 = "=htJ0*EXP(-0.5*((RC[-3]-LN(GMDJ0))^2/LN(GSDJ0)^2))"
    Range("E2").Select
    ActiveCell.FormulaR1C1 = "=(RC[-2]-RC[-1])^2"
    Range("D2:E2").Select
    Selection.AutoFill Destination:=Range("D2:E29")
    Range("D2:E29").Select
    Range("D2:E2").Select
    Selection.Copy
    Range("G2:H2").Select
    ActiveSheet.Paste
    Range("G2").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=htJ2*EXP(-0.5*((RC[-6]-LN(GMDJ2))^2/LN(GSDJ2)^2))"
    Range("G2:H2").Select
    Selection.AutoFill Destination:=Range("G2:H29")
    Range("G2:H29").Select
    Range("G2:H2").Select
    Selection.Copy
    Range("J2:K2").Select
    ActiveSheet.Paste
    Range("J2").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=htJ3*EXP(-0.5*((RC[-9]-LN(GMDJ3))^2/LN(GSDJ3)^2))"
    Range("J2:K2").Select
    Selection.AutoFill Destination:=Range("J2:K29")
    Range("J2:K29").Select
    Range("J2:K2").Select
    Selection.Copy
    Range("J2").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=htJ3*EXP(-0.5*((RC[-9]-LN(GMDJ3))^2/LN(GSDJ3)^2))"
    Range("J2:K2").Select
    Selection.Copy
    Range("M2:N2").Select
    ActiveSheet.Paste
    Range("M2").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = _
        "=htJ55*EXP(-0.5*((RC[-12]-LN(GMDJ55))^2/LN(GSDJ55)^2))"
    Range("M2:N2").Select
    Selection.AutoFill Destination:=Range("M2:N29")
    Range("M2:N29").Select
    Sheets("Fit Information").Select
    Range("B5").Select
    ActiveCell.FormulaR1C1 = "=SUM(Data!C[3])"
    Range("D5").Select
    ActiveCell.FormulaR1C1 = "=SUM(Data!C[4])"
    Range("F5").Select
    ActiveCell.FormulaR1C1 = "=SUM(Data!C[5])"
    Range("H5").Select
    ActiveCell.FormulaR1C1 = "=SUM(Data!C[6])"
    Range("B5").Select
    SolverReset
    SolverOk SetCell:="$B$5", MaxMinVal:=2, ValueOf:="0", ByChange:="$B$2:$B$4"
    SolverSolve
    Range("D5").Select
    SolverReset
    SolverOk SetCell:="$D$5", MaxMinVal:=2, ValueOf:="0", ByChange:="$D$2:$D$4"
    SolverSolve
    Range("F5").Select
    SolverReset
    SolverOk SetCell:="$F$5", MaxMinVal:=2, ValueOf:="0", ByChange:="$F$2:$F$4"
    SolverSolve
    Range("H5").Select
    SolverReset
    SolverOk SetCell:="$H$5", MaxMinVal:=2, ValueOf:="0", ByChange:="$H$2:$H$4"
    SolverSolve
    Sheets("Data").Select
    Columns("E:E").Select
    Selection.EntireColumn.Hidden = True
    Columns("H:H").Select
    Selection.EntireColumn.Hidden = True
    Columns("K:K").Select
    Selection.EntireColumn.Hidden = True
    Columns("N:N").Select
    Selection.EntireColumn.Hidden = True
    Columns("B:M").Select
    Charts.Add
    ActiveChart.ChartType = xlXYScatterSmooth
    ActiveChart.SetSourceData Source:=Sheets("Data").Range("B1:M114"), PlotBy:= _
        xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = True
        .ChartTitle.Characters.Text = "Particle Size Distribution"
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "D [nm]"
        .Axes(xlValue, xlPrimary).HasTitle = False
    End With
    ActiveChart.Axes(xlCategory).Select
    With Selection.Border
        .ColorIndex = 57
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MajorTickMark = xlOutside
        .MinorTickMark = xlOutside
        .TickLabelPosition = xlNextToAxis
    End With
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 10
        .MaximumScale = 100
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLogarithmic
    End With
    Selection.TickLabels.AutoScaleFont = True
    With Selection.TickLabels.Font
        .Name = "Arial"
        .FontStyle = "Regular"
        .Size = 14
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
        .Background = xlAutomatic
    End With
    ActiveChart.Axes(xlValue).MajorGridlines.Select
    Selection.Delete
    ActiveChart.Axes(xlValue).Select
    With Selection.Border
        .ColorIndex = 57
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MajorTickMark = xlOutside
        .MinorTickMark = xlNone
        .TickLabelPosition = xlNextToAxis
    End With
    With ActiveChart.Axes(xlValue)
        .MinimumScale = 0
        .MaximumScaleIsAuto = True
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
    End With
    Selection.TickLabels.AutoScaleFont = True
    With Selection.TickLabels.Font
        .Name = "Arial"
        .FontStyle = "Regular"
        .Size = 14
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
        .Background = xlAutomatic
    End With
    ActiveChart.SeriesCollection(1).Select
    With Selection.Border
        .Weight = xlThin
        .LineStyle = xlNone
    End With
    With Selection
        .MarkerBackgroundColorIndex = 1
        .MarkerForegroundColorIndex = 1
        .MarkerStyle = xlDiamond
        .Smooth = True
        .MarkerSize = 5
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(3).Select
    With Selection.Border
        .Weight = xlThin
        .LineStyle = xlNone
    End With
    With Selection
        .MarkerBackgroundColorIndex = 3
        .MarkerForegroundColorIndex = 3
        .MarkerStyle = xlTriangle
        .Smooth = True
        .MarkerSize = 5
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(5).Select
    With Selection.Border
        .Weight = xlThin
        .LineStyle = xlNone
    End With
    With Selection
        .MarkerBackgroundColorIndex = 10
        .MarkerForegroundColorIndex = 10
        .MarkerStyle = xlTriangle
        .Smooth = True
        .MarkerSize = 5
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(7).Select
    With Selection.Border
        .Weight = xlThin
        .LineStyle = xlNone
    End With
    With Selection
        .MarkerBackgroundColorIndex = 7
        .MarkerForegroundColorIndex = 7
        .MarkerStyle = xlSquare
        .Smooth = True
        .MarkerSize = 5
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(2).Select
    With Selection.Border
        .ColorIndex = 1
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = 1
        .MarkerStyle = xlNone
        .Smooth = True
        .MarkerSize = 5
        .Shadow = False
    End With
        ActiveChart.SeriesCollection(4).Select
    With Selection.Border
        .ColorIndex = 3
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = 3
        .MarkerStyle = xlNone
        .Smooth = True
        .MarkerSize = 5
        .Shadow = False
    End With
        ActiveChart.SeriesCollection(6).Select
    With Selection.Border
        .ColorIndex = 10
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = 10
        .MarkerStyle = xlNone
        .Smooth = True
        .MarkerSize = 5
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(8).Select
    With Selection.Border
        .ColorIndex = 7
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = 7
        .MarkerStyle = xlNone
        .Smooth = True
        .MarkerSize = 5
        .Shadow = False
    End With
    ActiveChart.PlotArea.Select
    With Selection.Border
        .ColorIndex = 1
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection.Interior
        .ColorIndex = 2
        .PatternColorIndex = 1
        .Pattern = xlSolid
    End With
    ActiveChart.ChartArea.Select
    Sheets("Chart1").Select
    Sheets("Chart1").Name = "PSD Plot"
End Sub
Sub GetEIAHeaderFile(FileName)
'   Set up file filter
    Filter = "EIA header files (*.hdr),*.hdr"
    FilterIndex = 3
    Title = "Select a file to import"
    FileName = Application.GetOpenFilename(Filter, _
        FilterIndex, Title)
    If FileName = False Then
        MsgBox "No file selected"
        Exit Sub
    End If
'    MsgBox "You selected " & FileName
End Sub
Sub GetEIAResultFile(FileName)
'   Set up file filter
    Filter = "EIA result files (*.eia),*.eia"
    FilterIndex = 3
    Title = "Select a file to import"
    FileName = Application.GetOpenFilename(Filter, _
        FilterIndex, Title)
    If FileName = False Then
        MsgBox "No file selected"
        Exit Sub
    End If
'    MsgBox "You selected " & FileName
End Sub
Sub GetEIASpreadsheetName(FileName)
'   Set up file filter
    Filter = "EIA Spreadsheet files (*.xls),*.xls"
    FilterIndex = 3
    Title = "Select a file to save"
    FileName = Application.GetSaveAsFilename(" ", Filter, _
        FilterIndex, Title)
    If FileName = False Then
        MsgBox "No file selected"
        Exit Sub
    End If
'    MsgBox "You selected " & FileName
End Sub


