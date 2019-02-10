
# Perl5-5.26.2. Ukraine. (C) Demidov S.V.
# Пример вызова: perl 'Vector-06C_Color_256.pl'

# ---
# | Цвета Вектор'а-06Ц через цвета PC компьютера.
# ---

# Выходной файл с цветами: 'Vector-06C_Color_256.1.png'
# Используется ImageMagick!

	# Для объявления переменных.
	use strict;

	# В случае возникновений каких-либо проблем нужно остановить работу скрипта.
	use warnings FATAL => 'all';

#
# Перевод пикселей в сантиметры.
#    См. = 2.54 * длина стороны в px / dpi
#
# Перевод сантиметров в пиксели.
#
#    Пиксели = длина стороны в см. * dpi / 2.54
#
	my $filename;    # Входной файл (файл подложка).
	my $newfilename; # Выходной файл (файл результата).

	my $convert; # Готовая команда для ImageMagick.

	my $x;  # Координата по x.
	my $y;  # Координата по y.
	my $xx; # Задаёт размер квадрата по x.
	my $yy; # Задаёт размер квадрата по y.

	my $colorsquare; # Цвет квадрата.

	my $R; # Счётчик красного цвета.
	my $G; # Счётчик зелёного цвета.
	my $B; # Счётчик синиго цвета.

	my $sizesquare; # Размер квадрата в см.
	my $skip;       # Отступ между квадратами.

	my $count; # Счётчик от 0 до 255.
	my $temp;  # Временный результат.

	my @array_PC_R; # Массив красного цвета.
	my @array_PC_G; # Массив зелёного цвета.
	my @array_PC_B; # Массив синиго цвета.

	# Цвета.
	@array_PC_R = (0, 36, 72, 108, 144, 180, 216, 255);
	@array_PC_G = (0, 36, 72, 108, 144, 180, 216, 255);
	@array_PC_B = (0, 85, 170, 255);

	# Файл подложка.
	$filename = 'Images PNG/Vector-06C_Color_256.empty.png';
	# Файл результата.
	$newfilename = 'Images PNG/Vector-06C_Color_256.1.png';

	# Размер квадрата в см.
	$sizesquare = 0.6 * 300 / 2.54;

	# Пропустить (отступ), в см.
	$skip = 0.1 * 300 / 2.54;

	$count = 0;

	$x = $skip;
	$y = $skip;

	print "\n";

	# 4.
	for ($B = 0; $B < @array_PC_B;)
		{
		# 8.
		for ($G = 0; $G < @array_PC_G;)
			{
			# 8.
			for ($R = 0; $R < @array_PC_R;)
				{
				print sprintf("%03d", $count) . '. ';

				$temp = sprintf("%02x", $array_PC_R[$R]);
				$temp.= sprintf("%02x", $array_PC_G[$G]);
				$temp.= sprintf("%02x", $array_PC_B[$B]);

				print 'Color: ' . $temp . '.';
				print "\n";

				$colorsquare = '#' . $temp;

				if ($count == 1)
					{
					$filename = $newfilename;
					}

				# Это размер квадрата.
				$yy = $y + $sizesquare;
				$xx = $x + $sizesquare;

				#             Координата вверх/вниз
				#             |  Координата влево/вправо.
				#             |  |
				# rectangle 0,50 50,0
				#           |       |
				#           |       По вертикали (y). | ---> Стать в позицию на изображение
				#           По горизонтали (x).       |      (от левого верхнего угла).

				$convert = "convert -fill \'$colorsquare\' -draw"; #
				$convert.= " \"rectangle $x,$yy $xx,$y\" ";        # Рисуем квадрат.
				$convert.= "\'" . $filename . "\' ";               #
				$convert.= "\'" . $newfilename . "\'";             #
				`$convert`;                                        #

				#<STDIN>;

				$x = $x + $sizesquare + $skip;

				$count++;

				$R++;
				}

			print "\n";

			$x = $skip;
			$y = $y + $sizesquare + $skip;

			$G++;
			}

		#<STDIN>;

		$y = $y + $sizesquare;

		$B++;
		}
