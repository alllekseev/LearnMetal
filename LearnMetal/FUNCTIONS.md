# Metal — Справочник функций

Краткий справочник всех изученных функций. Для подробной теории — см. THEORY.md.

---

## Математические

### step(edge, x)
Резкий переключатель.
```metal
step(edge, x)
// x < edge   →  0.0
// x >= edge  →  1.0
```

### smoothstep(edge0, edge1, x)
Плавный переключатель. S-образная кривая между edge0 и edge1.
```metal
smoothstep(edge0, edge1, x)
// x ≤ edge0  →  0.0
// x ≥ edge1  →  1.0
// между      →  плавно 0→1
```
Единицы edge0/edge1 — те же, что у x (пиксели, UV и т.д.).

### mix(a, b, t)
Смешивание двух значений по коэффициенту.
```metal
mix(a, b, t)
// t = 0.0  →  a
// t = 1.0  →  b
// t = 0.5  →  среднее
```
Работает с `float`, `half4` и другими типами.

### clamp(x, min, max)
Ограничивает значение в диапазоне.
```metal
clamp(x, 0.0, 1.0)
// x < 0.0  →  0.0
// x > 1.0  →  1.0
// иначе    →  x
```

### floor(x)
Округление вниз (отбрасывает дробную часть).
```metal
floor(0.7)  = 0
floor(1.3)  = 1
floor(7.9)  = 7
```
**Важно**: `floor(a) + floor(b)` ≠ `floor(a + b)`.

### fmod(a, b)
Остаток от деления (аналог `%` для float).
```metal
fmod(5.0, 2.0)  = 1.0
fmod(4.0, 2.0)  = 0.0
```

### abs(x)
Модуль числа (убирает знак).
```metal
abs(-5.0)  = 5.0
abs(3.0)   = 3.0
```

### min(a, b) / max(a, b)
Минимум / максимум из двух значений.
```metal
min(3.0, 7.0)  = 3.0
max(3.0, 7.0)  = 7.0
```

---

## Векторные

### length(v)
Длина вектора. Для двух точек — расстояние между ними.
```metal
length(float2(3.0, 4.0))  = 5.0   // √(9+16)
length(position - center)          // расстояние от пикселя до центра
```

---

## Типы данных

| Тип | Что это | Пример |
|---|---|---|
| `float` | Число с плавающей точкой | `0.5` |
| `float2` | Вектор из 2 чисел (x, y) | `float2(0.5, 0.5)` |
| `half4` | Вектор из 4 чисел (r, g, b, a) | `half4(1, 0, 0, 1)` |

### Broadcasting
Одно число автоматически "размножается" на все компоненты:
```metal
return mask;  // = half4(mask, mask, mask, mask)
```
**Осторожно**: 4-й компонент — альфа! `mask = 0` → полная прозрачность.

---

## Паттерны

### Разделение на полосы (step + mix)
```metal
// Две полосы
float t = step(0.5, uv.x);
return mix(colorA, colorB, t);

// Три полосы — цепочка
float s1 = step(0.33, uv.y);
float s2 = step(0.66, uv.y);
half4 first = mix(color1, color2, s1);
return mix(first, color3, s2);
```

### Чётность клетки (floor + fmod)
```metal
float col = floor(uv.x * 8.0);
float row = floor(uv.y * 8.0);
float isOdd = fmod(col + row, 2.0);
```

### SDF круга
```metal
float2 centered = position - size / 2.0;
float sdf = length(centered) - radius;
float mask = smoothstep(-1.0, 1.0, sdf);
```

### Комбинирование SDF
```metal
min(sdf1, sdf2)       // объединение (ИЛИ)
max(sdf1, sdf2)       // пересечение (И)
max(sdf1, -sdf2)      // вычитание
```

---

## Подключение из Swift

```swift
// Без параметров
ShaderCanvas(ShaderLibrary.Flag)

// С параметрами (в поинтах, как в Figma)
ShaderCanvas(ShaderLibrary.Circle, .float(200))

// С анимацией и параметрами
ShaderCanvas(ShaderLibrary.Circle, animated: true, .float(200))
```
