Cls
Dim linea As String
Dim n As Integer
Dim WE As Integer
Dim R As Integer
R = 1
Open "archivoMaleta.txt" For Input As #1
Do While Not EOF(1)
    Line Input #1, linea
    If R = 1 Then
        WE = Val(linea)
        R = R + 1
    Else
        n = Val(linea)
    End If
Loop
Close #1

Dim W(n) As Integer
Dim E(n) As Integer
Dim aux As Integer
Dim index As Integer
Dim linea2 As String
index = 1
Open "archivoObjetos.txt" For Input As #1
Do While Not EOF(1)
    Line Input #1, linea2
    espacio = InStr(linea2, " ")
    aux = Int(espacio)
    If aux > 0 Then
        W(index) = Val(Left$(linea2, aux - 1))
        E(index) = Val(Right$(linea2, Len(linea2) - aux))
    End If
    index = index + 1
Loop
Close #1

Print ("hola!")
Dim M As Integer
M = KNAPSACK(W(), E(), WE, n)

Function KNAPSACK (W() As Integer, V() As Integer, WE As Integer, N As Integer)
    Dim M(N + 1, WE + 1) As Integer
    For i = 1 To N
        For j = 1 To WE
            If i = 1 Then
                If W(i) < j Then
                    M(i, j) = V(i)
                End If
            ElseIf i > 1 Then
                If W(i) > j Then
                    M(i, j) = M(i - 1, j)
                Else
                    M(i, j) = max(M(i - 1, j), V(i) + M(i - 1, j - W(i)))
                End If
            End If
        Next j
    Next i
    Dim h As Integer
    h = WE
    Dim s(N + 1) As Integer
    Dim k As Integer
    k = N
    Dim x As Integer
    x = 1
    Do While k > 0
        If M(k - 1, h) <> M(k, h) Then
            If M(k, h) = V(k) + M(k - 1, h - W(k)) Then
                s(x) = k
                x = x + 1
                h = h - W(k)
            End If
        End If
        k = k - 1
    Loop
    Print ("el maximo valor que se puede obtener en una mochila de maximo " + Str$(WE) + " kilos es " + Str$(M(N, WE)))
    For i = 1 To N
        If s(i) <> 0 Then
            Print ("el objeto " + Str$(s(i)) + " con peso " + Str$(W(s(i))) + " y valor " + Str$(V(s(i))))
        End If
    Next i
    KNAPSACK = M(N, WE)
End Function

Function max (a As Integer, b As Integer)
    If a > b Then
        max = a
    Else
        max = b
    End If
End Function

