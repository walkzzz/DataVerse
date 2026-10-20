///===
/// extcore/signal_filter_chebyshev1

pub(all) struct Signalfilterchebyshev1Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_chebyshev1_make_point(x : Double, y : Double) -> Signalfilterchebyshev1Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_chebyshev1_make_point3(x : Double, y : Double, z : Double) -> Signalfilterchebyshev1Point {
  { x, y, z, label: 0 }
}

pub fn Signalfilterchebyshev1Point::x(self : Signalfilterchebyshev1Point) -> Double { self.x }

pub fn Signalfilterchebyshev1Point::y(self : Signalfilterchebyshev1Point) -> Double { self.y }

pub fn Signalfilterchebyshev1Point::z(self : Signalfilterchebyshev1Point) -> Double { self.z }

pub fn Signalfilterchebyshev1Point::label(self : Signalfilterchebyshev1Point) -> Int { self.label }

pub fn Signalfilterchebyshev1Point::dist(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Signalfilterchebyshev1Point::add(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Signalfilterchebyshev1Point::sub(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Signalfilterchebyshev1Point::scale(self : Signalfilterchebyshev1Point, s : Double) -> Signalfilterchebyshev1Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Signalfilterchebyshev1Point::dot(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Signalfilterchebyshev1Point::cross(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Signalfilterchebyshev1Point::norm(self : Signalfilterchebyshev1Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Signalfilterchebyshev1Point::normalize(self : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Signalfilterchebyshev1Point::negate(self : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Signalfilterchebyshev1Point::mid(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Signalfilterchebyshev1Point::lerp(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point, t : Double) -> Signalfilterchebyshev1Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Signalfilterchebyshev1Point::to_string(self : Signalfilterchebyshev1Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_chebyshev1_make_series(vals : Array[Double], name : String) -> Signalfilterchebyshev1Series {
  { vals, name, meta: 0 }
}

pub fn Signalfilterchebyshev1Series::len(self : Signalfilterchebyshev1Series) -> Int { self.vals.length() }

pub fn Signalfilterchebyshev1Series::sum(self : Signalfilterchebyshev1Series) -> Double { @_common.sum(self.vals) }

pub fn Signalfilterchebyshev1Series::mean(self : Signalfilterchebyshev1Series) -> Double { @_common.mean(self.vals) }

pub fn Signalfilterchebyshev1Series::min(self : Signalfilterchebyshev1Series) -> Double { @_common.min(self.vals) }

pub fn Signalfilterchebyshev1Series::max(self : Signalfilterchebyshev1Series) -> Double { @_common.max(self.vals) }

pub fn Signalfilterchebyshev1Series::range(self : Signalfilterchebyshev1Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Signalfilterchebyshev1Series::variance(self : Signalfilterchebyshev1Series) -> Double { @_common.variance(self.vals) }

pub fn Signalfilterchebyshev1Series::std(self : Signalfilterchebyshev1Series) -> Double { @_common.std(self.vals) }

pub fn Signalfilterchebyshev1Series::median(self : Signalfilterchebyshev1Series) -> Double { @_common.median(self.vals) }

pub fn Signalfilterchebyshev1Series::scale(self : Signalfilterchebyshev1Series, f : Double) -> Signalfilterchebyshev1Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Signalfilterchebyshev1Series::add(self : Signalfilterchebyshev1Series, other : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Signalfilterchebyshev1Series::sub(self : Signalfilterchebyshev1Series, other : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Signalfilterchebyshev1Series::normalize(self : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Signalfilterchebyshev1Series::cumsum(self : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Signalfilterchebyshev1Series::to_string(self : Signalfilterchebyshev1Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Signalfilterchebyshev1Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_chebyshev1_make_matrix(rows : Int, cols : Int, val : Double) -> Signalfilterchebyshev1Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_chebyshev1_matrix_identity(n : Int) -> Signalfilterchebyshev1Matrix {
  let m = signal_filter_chebyshev1_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Signalfilterchebyshev1Matrix::get(self : Signalfilterchebyshev1Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Signalfilterchebyshev1Matrix::transpose(self : Signalfilterchebyshev1Matrix) -> Signalfilterchebyshev1Matrix {
  let result = signal_filter_chebyshev1_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Signalfilterchebyshev1Matrix::add(self : Signalfilterchebyshev1Matrix, other : Signalfilterchebyshev1Matrix) -> Signalfilterchebyshev1Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_chebyshev1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Signalfilterchebyshev1Matrix::scale(self : Signalfilterchebyshev1Matrix, s : Double) -> Signalfilterchebyshev1Matrix {
  let result = signal_filter_chebyshev1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Signalfilterchebyshev1Matrix::multiply(self : Signalfilterchebyshev1Matrix, other : Signalfilterchebyshev1Matrix) -> Signalfilterchebyshev1Matrix {
  if self.cols != other.rows { return signal_filter_chebyshev1_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_chebyshev1_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Signalfilterchebyshev1Matrix::trace(self : Signalfilterchebyshev1Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Signalfilterchebyshev1Matrix::det(self : Signalfilterchebyshev1Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Signalfilterchebyshev1Matrix::norm(self : Signalfilterchebyshev1Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Signalfilterchebyshev1Matrix::to_string(self : Signalfilterchebyshev1Matrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Signalfilterchebyshev1Vector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_chebyshev1_make_vector(comps : Array[Double]) -> Signalfilterchebyshev1Vector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_chebyshev1_vector_zero(dim : Int) -> Signalfilterchebyshev1Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Signalfilterchebyshev1Vector::add(self : Signalfilterchebyshev1Vector, other : Signalfilterchebyshev1Vector) -> Signalfilterchebyshev1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Signalfilterchebyshev1Vector::sub(self : Signalfilterchebyshev1Vector, other : Signalfilterchebyshev1Vector) -> Signalfilterchebyshev1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Signalfilterchebyshev1Vector::scale(self : Signalfilterchebyshev1Vector, s : Double) -> Signalfilterchebyshev1Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Signalfilterchebyshev1Vector::dot(self : Signalfilterchebyshev1Vector, other : Signalfilterchebyshev1Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Signalfilterchebyshev1Vector::norm(self : Signalfilterchebyshev1Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Signalfilterchebyshev1Vector::normalize(self : Signalfilterchebyshev1Vector) -> Signalfilterchebyshev1Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Signalfilterchebyshev1Vector::dist(self : Signalfilterchebyshev1Vector, other : Signalfilterchebyshev1Vector) -> Double {
  self.sub(other).norm()
}

pub fn Signalfilterchebyshev1Vector::to_string(self : Signalfilterchebyshev1Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Signalfilterchebyshev1Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_frame_make(size : Int) -> Signalfilterchebyshev1Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Frame::len(self : Signalfilterchebyshev1Frame) -> Int { self.size }

pub fn Signalfilterchebyshev1Frame::get(self : Signalfilterchebyshev1Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Frame::set(self : Signalfilterchebyshev1Frame, i : Int, v : Double) -> Signalfilterchebyshev1Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Frame::sum(self : Signalfilterchebyshev1Frame) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Frame::mean(self : Signalfilterchebyshev1Frame) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Frame::scale(self : Signalfilterchebyshev1Frame, f : Double) -> Signalfilterchebyshev1Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Frame::add(self : Signalfilterchebyshev1Frame, other : Signalfilterchebyshev1Frame) -> Signalfilterchebyshev1Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Frame::copy(self : Signalfilterchebyshev1Frame) -> Signalfilterchebyshev1Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Frame::fill(self : Signalfilterchebyshev1Frame, v : Double) -> Signalfilterchebyshev1Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Frame::min(self : Signalfilterchebyshev1Frame) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Frame::max(self : Signalfilterchebyshev1Frame) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Frame::to_string(self : Signalfilterchebyshev1Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_table_make(size : Int) -> Signalfilterchebyshev1Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Table::len(self : Signalfilterchebyshev1Table) -> Int { self.size }

pub fn Signalfilterchebyshev1Table::get(self : Signalfilterchebyshev1Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Table::set(self : Signalfilterchebyshev1Table, i : Int, v : Double) -> Signalfilterchebyshev1Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Table::sum(self : Signalfilterchebyshev1Table) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Table::mean(self : Signalfilterchebyshev1Table) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Table::scale(self : Signalfilterchebyshev1Table, f : Double) -> Signalfilterchebyshev1Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Table::add(self : Signalfilterchebyshev1Table, other : Signalfilterchebyshev1Table) -> Signalfilterchebyshev1Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Table::copy(self : Signalfilterchebyshev1Table) -> Signalfilterchebyshev1Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Table::fill(self : Signalfilterchebyshev1Table, v : Double) -> Signalfilterchebyshev1Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Table::min(self : Signalfilterchebyshev1Table) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Table::max(self : Signalfilterchebyshev1Table) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Table::to_string(self : Signalfilterchebyshev1Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_graphn_make(size : Int) -> Signalfilterchebyshev1GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1GraphN::len(self : Signalfilterchebyshev1GraphN) -> Int { self.size }

pub fn Signalfilterchebyshev1GraphN::get(self : Signalfilterchebyshev1GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1GraphN::set(self : Signalfilterchebyshev1GraphN, i : Int, v : Double) -> Signalfilterchebyshev1GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1GraphN::sum(self : Signalfilterchebyshev1GraphN) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1GraphN::mean(self : Signalfilterchebyshev1GraphN) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1GraphN::scale(self : Signalfilterchebyshev1GraphN, f : Double) -> Signalfilterchebyshev1GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1GraphN::add(self : Signalfilterchebyshev1GraphN, other : Signalfilterchebyshev1GraphN) -> Signalfilterchebyshev1GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1GraphN::copy(self : Signalfilterchebyshev1GraphN) -> Signalfilterchebyshev1GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1GraphN::fill(self : Signalfilterchebyshev1GraphN, v : Double) -> Signalfilterchebyshev1GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1GraphN::min(self : Signalfilterchebyshev1GraphN) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1GraphN::max(self : Signalfilterchebyshev1GraphN) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1GraphN::to_string(self : Signalfilterchebyshev1GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_node_make(size : Int) -> Signalfilterchebyshev1Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Node::len(self : Signalfilterchebyshev1Node) -> Int { self.size }

pub fn Signalfilterchebyshev1Node::get(self : Signalfilterchebyshev1Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Node::set(self : Signalfilterchebyshev1Node, i : Int, v : Double) -> Signalfilterchebyshev1Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Node::sum(self : Signalfilterchebyshev1Node) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Node::mean(self : Signalfilterchebyshev1Node) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Node::scale(self : Signalfilterchebyshev1Node, f : Double) -> Signalfilterchebyshev1Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Node::add(self : Signalfilterchebyshev1Node, other : Signalfilterchebyshev1Node) -> Signalfilterchebyshev1Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Node::copy(self : Signalfilterchebyshev1Node) -> Signalfilterchebyshev1Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Node::fill(self : Signalfilterchebyshev1Node, v : Double) -> Signalfilterchebyshev1Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Node::min(self : Signalfilterchebyshev1Node) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Node::max(self : Signalfilterchebyshev1Node) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Node::to_string(self : Signalfilterchebyshev1Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_edge_make(size : Int) -> Signalfilterchebyshev1Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Edge::len(self : Signalfilterchebyshev1Edge) -> Int { self.size }

pub fn Signalfilterchebyshev1Edge::get(self : Signalfilterchebyshev1Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Edge::set(self : Signalfilterchebyshev1Edge, i : Int, v : Double) -> Signalfilterchebyshev1Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Edge::sum(self : Signalfilterchebyshev1Edge) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Edge::mean(self : Signalfilterchebyshev1Edge) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Edge::scale(self : Signalfilterchebyshev1Edge, f : Double) -> Signalfilterchebyshev1Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Edge::add(self : Signalfilterchebyshev1Edge, other : Signalfilterchebyshev1Edge) -> Signalfilterchebyshev1Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Edge::copy(self : Signalfilterchebyshev1Edge) -> Signalfilterchebyshev1Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Edge::fill(self : Signalfilterchebyshev1Edge, v : Double) -> Signalfilterchebyshev1Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Edge::min(self : Signalfilterchebyshev1Edge) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Edge::max(self : Signalfilterchebyshev1Edge) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Edge::to_string(self : Signalfilterchebyshev1Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_path_make(size : Int) -> Signalfilterchebyshev1Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Path::len(self : Signalfilterchebyshev1Path) -> Int { self.size }

pub fn Signalfilterchebyshev1Path::get(self : Signalfilterchebyshev1Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Path::set(self : Signalfilterchebyshev1Path, i : Int, v : Double) -> Signalfilterchebyshev1Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Path::sum(self : Signalfilterchebyshev1Path) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Path::mean(self : Signalfilterchebyshev1Path) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Path::scale(self : Signalfilterchebyshev1Path, f : Double) -> Signalfilterchebyshev1Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Path::add(self : Signalfilterchebyshev1Path, other : Signalfilterchebyshev1Path) -> Signalfilterchebyshev1Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Path::copy(self : Signalfilterchebyshev1Path) -> Signalfilterchebyshev1Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Path::fill(self : Signalfilterchebyshev1Path, v : Double) -> Signalfilterchebyshev1Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Path::min(self : Signalfilterchebyshev1Path) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Path::max(self : Signalfilterchebyshev1Path) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Path::to_string(self : Signalfilterchebyshev1Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_cluster_make(size : Int) -> Signalfilterchebyshev1Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Cluster::len(self : Signalfilterchebyshev1Cluster) -> Int { self.size }

pub fn Signalfilterchebyshev1Cluster::get(self : Signalfilterchebyshev1Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Cluster::set(self : Signalfilterchebyshev1Cluster, i : Int, v : Double) -> Signalfilterchebyshev1Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cluster::sum(self : Signalfilterchebyshev1Cluster) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Cluster::mean(self : Signalfilterchebyshev1Cluster) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Cluster::scale(self : Signalfilterchebyshev1Cluster, f : Double) -> Signalfilterchebyshev1Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cluster::add(self : Signalfilterchebyshev1Cluster, other : Signalfilterchebyshev1Cluster) -> Signalfilterchebyshev1Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cluster::copy(self : Signalfilterchebyshev1Cluster) -> Signalfilterchebyshev1Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cluster::fill(self : Signalfilterchebyshev1Cluster, v : Double) -> Signalfilterchebyshev1Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cluster::min(self : Signalfilterchebyshev1Cluster) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Cluster::max(self : Signalfilterchebyshev1Cluster) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Cluster::to_string(self : Signalfilterchebyshev1Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_model_make(size : Int) -> Signalfilterchebyshev1Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Model::len(self : Signalfilterchebyshev1Model) -> Int { self.size }

pub fn Signalfilterchebyshev1Model::get(self : Signalfilterchebyshev1Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Model::set(self : Signalfilterchebyshev1Model, i : Int, v : Double) -> Signalfilterchebyshev1Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Model::sum(self : Signalfilterchebyshev1Model) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Model::mean(self : Signalfilterchebyshev1Model) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Model::scale(self : Signalfilterchebyshev1Model, f : Double) -> Signalfilterchebyshev1Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Model::add(self : Signalfilterchebyshev1Model, other : Signalfilterchebyshev1Model) -> Signalfilterchebyshev1Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Model::copy(self : Signalfilterchebyshev1Model) -> Signalfilterchebyshev1Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Model::fill(self : Signalfilterchebyshev1Model, v : Double) -> Signalfilterchebyshev1Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Model::min(self : Signalfilterchebyshev1Model) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Model::max(self : Signalfilterchebyshev1Model) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Model::to_string(self : Signalfilterchebyshev1Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_layer_make(size : Int) -> Signalfilterchebyshev1Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Layer::len(self : Signalfilterchebyshev1Layer) -> Int { self.size }

pub fn Signalfilterchebyshev1Layer::get(self : Signalfilterchebyshev1Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Layer::set(self : Signalfilterchebyshev1Layer, i : Int, v : Double) -> Signalfilterchebyshev1Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Layer::sum(self : Signalfilterchebyshev1Layer) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Layer::mean(self : Signalfilterchebyshev1Layer) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Layer::scale(self : Signalfilterchebyshev1Layer, f : Double) -> Signalfilterchebyshev1Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Layer::add(self : Signalfilterchebyshev1Layer, other : Signalfilterchebyshev1Layer) -> Signalfilterchebyshev1Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Layer::copy(self : Signalfilterchebyshev1Layer) -> Signalfilterchebyshev1Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Layer::fill(self : Signalfilterchebyshev1Layer, v : Double) -> Signalfilterchebyshev1Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Layer::min(self : Signalfilterchebyshev1Layer) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Layer::max(self : Signalfilterchebyshev1Layer) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Layer::to_string(self : Signalfilterchebyshev1Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_buffer_make(size : Int) -> Signalfilterchebyshev1Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Buffer::len(self : Signalfilterchebyshev1Buffer) -> Int { self.size }

pub fn Signalfilterchebyshev1Buffer::get(self : Signalfilterchebyshev1Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Buffer::set(self : Signalfilterchebyshev1Buffer, i : Int, v : Double) -> Signalfilterchebyshev1Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Buffer::sum(self : Signalfilterchebyshev1Buffer) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Buffer::mean(self : Signalfilterchebyshev1Buffer) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Buffer::scale(self : Signalfilterchebyshev1Buffer, f : Double) -> Signalfilterchebyshev1Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Buffer::add(self : Signalfilterchebyshev1Buffer, other : Signalfilterchebyshev1Buffer) -> Signalfilterchebyshev1Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Buffer::copy(self : Signalfilterchebyshev1Buffer) -> Signalfilterchebyshev1Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Buffer::fill(self : Signalfilterchebyshev1Buffer, v : Double) -> Signalfilterchebyshev1Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Buffer::min(self : Signalfilterchebyshev1Buffer) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Buffer::max(self : Signalfilterchebyshev1Buffer) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Buffer::to_string(self : Signalfilterchebyshev1Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_cursor_make(size : Int) -> Signalfilterchebyshev1Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Cursor::len(self : Signalfilterchebyshev1Cursor) -> Int { self.size }

pub fn Signalfilterchebyshev1Cursor::get(self : Signalfilterchebyshev1Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Cursor::set(self : Signalfilterchebyshev1Cursor, i : Int, v : Double) -> Signalfilterchebyshev1Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cursor::sum(self : Signalfilterchebyshev1Cursor) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Cursor::mean(self : Signalfilterchebyshev1Cursor) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Cursor::scale(self : Signalfilterchebyshev1Cursor, f : Double) -> Signalfilterchebyshev1Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cursor::add(self : Signalfilterchebyshev1Cursor, other : Signalfilterchebyshev1Cursor) -> Signalfilterchebyshev1Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cursor::copy(self : Signalfilterchebyshev1Cursor) -> Signalfilterchebyshev1Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cursor::fill(self : Signalfilterchebyshev1Cursor, v : Double) -> Signalfilterchebyshev1Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Cursor::min(self : Signalfilterchebyshev1Cursor) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Cursor::max(self : Signalfilterchebyshev1Cursor) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Cursor::to_string(self : Signalfilterchebyshev1Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_view_make(size : Int) -> Signalfilterchebyshev1View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1View::len(self : Signalfilterchebyshev1View) -> Int { self.size }

pub fn Signalfilterchebyshev1View::get(self : Signalfilterchebyshev1View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1View::set(self : Signalfilterchebyshev1View, i : Int, v : Double) -> Signalfilterchebyshev1View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1View::sum(self : Signalfilterchebyshev1View) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1View::mean(self : Signalfilterchebyshev1View) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1View::scale(self : Signalfilterchebyshev1View, f : Double) -> Signalfilterchebyshev1View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1View::add(self : Signalfilterchebyshev1View, other : Signalfilterchebyshev1View) -> Signalfilterchebyshev1View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1View::copy(self : Signalfilterchebyshev1View) -> Signalfilterchebyshev1View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1View::fill(self : Signalfilterchebyshev1View, v : Double) -> Signalfilterchebyshev1View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1View::min(self : Signalfilterchebyshev1View) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1View::max(self : Signalfilterchebyshev1View) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1View::to_string(self : Signalfilterchebyshev1View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_range_make(size : Int) -> Signalfilterchebyshev1Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Range::len(self : Signalfilterchebyshev1Range) -> Int { self.size }

pub fn Signalfilterchebyshev1Range::get(self : Signalfilterchebyshev1Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Range::set(self : Signalfilterchebyshev1Range, i : Int, v : Double) -> Signalfilterchebyshev1Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Range::sum(self : Signalfilterchebyshev1Range) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Range::mean(self : Signalfilterchebyshev1Range) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Range::scale(self : Signalfilterchebyshev1Range, f : Double) -> Signalfilterchebyshev1Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Range::add(self : Signalfilterchebyshev1Range, other : Signalfilterchebyshev1Range) -> Signalfilterchebyshev1Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Range::copy(self : Signalfilterchebyshev1Range) -> Signalfilterchebyshev1Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Range::fill(self : Signalfilterchebyshev1Range, v : Double) -> Signalfilterchebyshev1Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Range::min(self : Signalfilterchebyshev1Range) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Range::max(self : Signalfilterchebyshev1Range) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Range::to_string(self : Signalfilterchebyshev1Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_slice_make(size : Int) -> Signalfilterchebyshev1Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Signalfilterchebyshev1Slice::len(self : Signalfilterchebyshev1Slice) -> Int { self.size }

pub fn Signalfilterchebyshev1Slice::get(self : Signalfilterchebyshev1Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Signalfilterchebyshev1Slice::set(self : Signalfilterchebyshev1Slice, i : Int, v : Double) -> Signalfilterchebyshev1Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Slice::sum(self : Signalfilterchebyshev1Slice) -> Double { @_common.sum(self.data) }

pub fn Signalfilterchebyshev1Slice::mean(self : Signalfilterchebyshev1Slice) -> Double { @_common.mean(self.data) }

pub fn Signalfilterchebyshev1Slice::scale(self : Signalfilterchebyshev1Slice, f : Double) -> Signalfilterchebyshev1Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Slice::add(self : Signalfilterchebyshev1Slice, other : Signalfilterchebyshev1Slice) -> Signalfilterchebyshev1Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Signalfilterchebyshev1Slice::copy(self : Signalfilterchebyshev1Slice) -> Signalfilterchebyshev1Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Slice::fill(self : Signalfilterchebyshev1Slice, v : Double) -> Signalfilterchebyshev1Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Signalfilterchebyshev1Slice::min(self : Signalfilterchebyshev1Slice) -> Double { @_common.min(self.data) }

pub fn Signalfilterchebyshev1Slice::max(self : Signalfilterchebyshev1Slice) -> Double { @_common.max(self.data) }

pub fn Signalfilterchebyshev1Slice::to_string(self : Signalfilterchebyshev1Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

