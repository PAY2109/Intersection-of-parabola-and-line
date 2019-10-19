defmodule Lab2 do
  def solvea(x0, y0, x1, y1, x2, y2) do # Функция нахождения коэффициентов параболы
    opred = matrixopred(x0,x1,x2)
    solvedmatrix = 0
    if (opred != 0) do
      minors = matrixminors(x0,x1,x2)
      dops = matrixadops(minors)
      transp = matrixtransp(dops)
      obrat = matrixobrat(opred, transp)
      solvedmatrix = matrixmul(obrat,y0,y1,y2)
    else
      solvedmatrix = "Nevozmozhno naiti parabolu"
    end

  end

  def matrixopred(x0,x1,x2) do # Функция нахождения определителя матрицы
    list = {x0 * x0, x0, 1, x1*x1, x1, 1, x2*x2, x2, 1} #actually its a tuple
    opred = (elem(list, 0) * elem(list, 4) * elem(list, 8))
    opred = opred + (elem(list,6) * elem(list,1) * elem(list,5))
    opred = opred + (elem(list,3) * elem(list,7) * elem(list,2))
    opred = opred - (elem(list,6) * elem(list,4) * elem(list,2))
    opred = opred - (elem(list,0) * elem(list,7) * elem(list,5))
    opred = opred - (elem(list,3) * elem(list,1) * elem(list,8))
    opred
  end

  def matrixminors(x0,x1,x2) do # Функция нахождения матрицы миноров
    tuple = {x0 * x0, x0, 1, x1*x1, x1, 1, x2*x2, x2, 1}
    minors = {0, 0, 0, 0, 0, 0, 0, 0, 0,}
    minors = put_elem(minors, 0, elem(tuple, 4) * elem(tuple,8) - (elem(tuple,5) * elem(tuple,7)))
    minors = put_elem(minors, 1, elem(tuple, 3) * elem(tuple,8) - (elem(tuple,5) * elem(tuple,6)))
    minors = put_elem(minors, 2, elem(tuple, 3) * elem(tuple,7) - (elem(tuple,4) * elem(tuple,6)))
    minors = put_elem(minors, 3, elem(tuple, 1) * elem(tuple,8) - (elem(tuple,2) * elem(tuple,7)))
    minors = put_elem(minors, 4, elem(tuple, 0) * elem(tuple,8) - (elem(tuple,2) * elem(tuple,6)))
    minors = put_elem(minors, 5, elem(tuple, 0) * elem(tuple,7) - (elem(tuple,1) * elem(tuple,6)))
    minors = put_elem(minors, 6, elem(tuple, 1) * elem(tuple,5) - (elem(tuple,2) * elem(tuple,4)))
    minors = put_elem(minors, 7, elem(tuple, 0) * elem(tuple,5) - (elem(tuple,2) * elem(tuple,3)))
    minors = put_elem(minors, 8, elem(tuple, 0) * elem(tuple,4) - (elem(tuple,1) * elem(tuple,3)))
  end

  def matrixadops(minors) do # Функция нахождения матрицы алгебраических дополнений
    dops = minors
    dops = put_elem(dops, 1, -elem(minors,1))
    dops = put_elem(dops, 3, -elem(minors,3))
    dops = put_elem(dops, 5, -elem(minors,5))
    dops = put_elem(dops, 7, -elem(minors,7))
  end

  def matrixtransp(dops) do # Функция нахождения транспонированной матрицы
    temp = elem(dops, 1)
    dops = put_elem(dops,1, elem(dops,3))
    dops = put_elem(dops, 3, temp)
    temp = elem(dops, 2)
    dops = put_elem(dops, 2, elem(dops, 6))
    dops = put_elem(dops, 6, temp)
    temp = elem(dops, 5)
    dops = put_elem(dops, 5, elem(dops, 7))
    dops = put_elem(dops, 7, temp)

  end

  def matrixobrat(opred, transp) do # Функция нахождения обратной матрицы
    mnozh = 1/opred
    transp = put_elem(transp, 0, elem(transp, 0) * mnozh)
    transp = put_elem(transp, 1, elem(transp, 1) * mnozh)
    transp = put_elem(transp, 2, elem(transp, 2) * mnozh)
    transp = put_elem(transp, 3, elem(transp, 3) * mnozh)
    transp = put_elem(transp, 4, elem(transp, 4) * mnozh)
    transp = put_elem(transp, 5, elem(transp, 5) * mnozh)
    transp = put_elem(transp, 6, elem(transp, 6) * mnozh)
    transp = put_elem(transp, 7, elem(transp, 7) * mnozh)
    transp = put_elem(transp, 8, elem(transp, 8) * mnozh)
  end

  def matrixmul(obrat, y0, y1, y2) do # Функция умножения  матриц
    proiz = {0, 0, 0}
    proiz = put_elem(proiz, 0, elem(obrat,0) * y0 + elem(obrat,1) * y1 + elem(obrat,2) * y2 )
    proiz = put_elem(proiz, 1, elem(obrat,3) * y0 + elem(obrat,4) * y1 + elem(obrat,5) * y2 )
    proiz = put_elem(proiz, 2, elem(obrat,6) * y0 + elem(obrat,7) * y1 + elem(obrat,8) * y2 )
  end
  def pryamaya(x0, y0, x1, y1) when x1 != x0 do # Функция нахождения коэффициентов прямой (обычный случай)
    k = (y0 - y1)/(x0 - x1)
    b = -(k * x0) + y0
    vivod = {k, b, 0}
  end

  def pryamaya(x0, y0, x1, y1) do # Функция нахождения коэффициентов прямой (Прямая перпендикулярна оси абсцисс)
    k = 0
    b = x0
    vivod = {x0, b, 1}
  end

  def findpoints(x0, y0, x1, y1, x2, y2, x3, y3, x4, y4) do # Функция нахождения точек пересечений (основная функция)
    vivod = 0
    if (x3 == x4 && y3 == y4) do
      vivod = "Vvedeny odinakovie tochki!"

    else
    abc = solvea(x0, y0, x1, y1, x2, y2)



      if (abc != "Nevozmozhno naiti parabolu") do
        kb = pryamaya(x3, y3, x4, y4)


        a = elem(abc, 0)
        if (a != 0) do
          IO.puts "Koefficienty paraboli a, b, c:"
          IO.inspect abc
          if (elem(kb,2) == 0) do
            IO.puts "Koefficient pryamoy k:"
            IO.inspect elem(kb,0)
            IO.puts "Koefficient pryamoy b:"
            IO.inspect elem(kb,1)
            b1 = elem(abc, 1) - elem(kb, 0)
            c = elem(abc, 2) - elem(kb, 1)
            d = (b1*b1) - (4 * a * c)
            vivod = output(a, b1, c, d, elem(kb, 0), elem(kb, 1))
            IO.puts "Koordinaty tochek peresecheniya:"
            IO.inspect vivod
          end

          if (elem(kb,2) == 1) do
            b1 = elem(abc, 1)
            c = elem(abc, 2)
            IO.puts "Pryamaya x = "
            IO.inspect elem(kb,0)
            vivod = pts(a, b1, c, elem(kb,0))
            IO.puts "Koordinaty tochki peresecheniya:"
            IO.inspect vivod
          end
        else
          IO.puts "Paraboli ne sushestvuet"
        end

      end

      if (abc == "Nevozmozhno naiti parabolu") do
        vivod = "Nevozmozhno naiti parabolu"
      end
    end
  end

  def output(a, b1, c, d, k, b) when d > 0 do # Функция нахождения точек, если дискриминант больше 0
    sqrtD = :math.sqrt(d)
    x1 = (-b1 + sqrtD) / (2 * a)
    x2 = (-b1 - sqrtD) / (2 * a)
    y1 = k * x1 + b
    y2 = k * x2 + b
    vivod = {x1, y1, x2, y2}

  end

  def output(a, b1, c, d, k, b) when d == 0 do # Функция нахождения точек, если дискриминант равен 0
    x1 = -b1 / (2 * a)
    y1 = k * x1 + b
    vivod = {x1, y1}
  end

  def output(a, b1, c, d, k, b) do # Функция нахождения точек, если дискриминант меньше 0
    vivod = "Net peresecheniy"
  end

  def pts(a, b1, c, prx) do # Функция нахождения точки, если прямая перпендикулярна оси абсцисс
    y = a*prx*prx + b1 * prx + c
    vivod = {prx, y}

  end
end

#IO.inspect Lab2.matrixopred(-1,-4, 1, -2, 3, 16)
#IO.inspect Lab2.matrixminors(-1,-4, 1, -2, 3, 16)
#IO.inspect Lab2.solvea(-1,-4, 1, -2, 3, 16)
#IO.inspect Lab2.pryamaya(4, -1, 3, -6)
#Lab2.findpoints(-1,-4, 1, -2, 3, 16, 0, 0, 1, 1)
#IO.inspect Lab2.pryamaya(0,0,1,1)
#IO.inspect Lab2.solvea(-1,-4, 1, -2, 3, 16)
#IO.inspect Lab2.solvea(2, 3, 4, 3, 3, -1)
#IO.inspect Lab2.matrixopred(2, 4, 3)
#IO.inspect Lab2.pryamaya(3,0,3,1)
#IO.inspect Lab2.findpoints(2,3, 4, 3, 3, -1, 3, 0, 3, 1)
#IO.inspect Lab2.findpoints(-3,-9, 2, 21, -4, -3, 100, 4, 100, -17)
#IO.inspect Lab2.solvea(-3,-9, 2, 21, -4, -3)
#IO.inspect Lab2.pryamaya(6, 1, 0, -8)
#IO.inspect Lab2.findpoints(-3,-9, 2, 21, -4, -3, 6, 1, 0, -8)
#IO.inspect Lab2.findpoints(-3,-9, 2, 21, -4, -3, 10, 4, -4, -17)
#IO.inspect Lab2.findpoints(1, 6, -2, -4.5, 0, 1.5, 0, 1, 1, 4)
#IO.inspect Lab2.findpoints(0,-1.5, -2, 4.5, -1, 2, -5, 14, 2, -7)
#IO.inspect Lab2.findpoints(1, 2, 3, 4, 5, 6, 7, 2, 5, 7)
#IO.inspect Lab2.findpoints(1, 2, 7, 4, 7, 9, 7, 2, 5, 7)
#IO.inspect Lab2.solvea(1, 2, 5, 4, 7, 9)
#IO.inspect Lab2.pryamaya(6,2,6,7)
IO.inspect Lab2.findpoints(1, 2, 5, 4, 7, 9, 6, 2, 6, 7)
#IO.inspect Lab2.findpoints(-2, 4, 0, 0, 2, 4, 0, 0, 0, 0)
