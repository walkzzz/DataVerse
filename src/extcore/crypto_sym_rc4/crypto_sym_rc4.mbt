///===
/// extcore/crypto_sym_rc4

pub(all) struct Cryptosymrc4Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_rc4_make_point(x : Double, y : Double) -> Cryptosymrc4Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_rc4_make_point3(x : Double, y : Double, z : Double) -> Cryptosymrc4Point {
  { x, y, z, label: 0 }
}

pub fn Cryptosymrc4Point::x(self : Cryptosymrc4Point) -> Double { self.x }

pub fn Cryptosymrc4Point::y(self : Cryptosymrc4Point) -> Double { self.y }

pub fn Cryptosymrc4Point::z(self : Cryptosymrc4Point) -> Double { self.z }

pub fn Cryptosymrc4Point::label(self : Cryptosymrc4Point) -> Int { self.label }

pub fn Cryptosymrc4Point::dist(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptosymrc4Point::add(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptosymrc4Point::sub(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptosymrc4Point::scale(self : Cryptosymrc4Point, s : Double) -> Cryptosymrc4Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptosymrc4Point::dot(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptosymrc4Point::cross(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptosymrc4Point::norm(self : Cryptosymrc4Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptosymrc4Point::normalize(self : Cryptosymrc4Point) -> Cryptosymrc4Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptosymrc4Point::negate(self : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptosymrc4Point::mid(self : Cryptosymrc4Point, other : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptosymrc4Point::lerp(self : Cryptosymrc4Point, other : Cryptosymrc4Point, t : Double) -> Cryptosymrc4Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptosymrc4Point::to_string(self : Cryptosymrc4Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptosymrc4Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_rc4_make_series(vals : Array[Double], name : String) -> Cryptosymrc4Series {
  { vals, name, meta: 0 }
}

pub fn Cryptosymrc4Series::len(self : Cryptosymrc4Series) -> Int { self.vals.length() }

pub fn Cryptosymrc4Series::sum(self : Cryptosymrc4Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptosymrc4Series::mean(self : Cryptosymrc4Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptosymrc4Series::min(self : Cryptosymrc4Series) -> Double { @_common.min(self.vals) }

pub fn Cryptosymrc4Series::max(self : Cryptosymrc4Series) -> Double { @_common.max(self.vals) }

pub fn Cryptosymrc4Series::range(self : Cryptosymrc4Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptosymrc4Series::variance(self : Cryptosymrc4Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptosymrc4Series::std(self : Cryptosymrc4Series) -> Double { @_common.std(self.vals) }

pub fn Cryptosymrc4Series::median(self : Cryptosymrc4Series) -> Double { @_common.median(self.vals) }

pub fn Cryptosymrc4Series::scale(self : Cryptosymrc4Series, f : Double) -> Cryptosymrc4Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptosymrc4Series::add(self : Cryptosymrc4Series, other : Cryptosymrc4Series) -> Cryptosymrc4Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptosymrc4Series::sub(self : Cryptosymrc4Series, other : Cryptosymrc4Series) -> Cryptosymrc4Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptosymrc4Series::normalize(self : Cryptosymrc4Series) -> Cryptosymrc4Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptosymrc4Series::cumsum(self : Cryptosymrc4Series) -> Cryptosymrc4Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptosymrc4Series::to_string(self : Cryptosymrc4Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptosymrc4Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_rc4_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptosymrc4Matrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn crypto_sym_rc4_matrix_identity(n : Int) -> Cryptosymrc4Matrix {
  let m = crypto_sym_rc4_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptosymrc4Matrix::get(self : Cryptosymrc4Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptosymrc4Matrix::transpose(self : Cryptosymrc4Matrix) -> Cryptosymrc4Matrix {
  let result = crypto_sym_rc4_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptosymrc4Matrix::add(self : Cryptosymrc4Matrix, other : Cryptosymrc4Matrix) -> Cryptosymrc4Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_rc4_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptosymrc4Matrix::scale(self : Cryptosymrc4Matrix, s : Double) -> Cryptosymrc4Matrix {
  let result = crypto_sym_rc4_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptosymrc4Matrix::multiply(self : Cryptosymrc4Matrix, other : Cryptosymrc4Matrix) -> Cryptosymrc4Matrix {
  if self.cols != other.rows { return crypto_sym_rc4_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_rc4_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Cryptosymrc4Matrix::trace(self : Cryptosymrc4Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptosymrc4Matrix::det(self : Cryptosymrc4Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptosymrc4Matrix::norm(self : Cryptosymrc4Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptosymrc4Matrix::to_string(self : Cryptosymrc4Matrix) -> String {
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

pub(all) struct Cryptosymrc4Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_rc4_make_vector(comps : Array[Double]) -> Cryptosymrc4Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_rc4_vector_zero(dim : Int) -> Cryptosymrc4Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptosymrc4Vector::add(self : Cryptosymrc4Vector, other : Cryptosymrc4Vector) -> Cryptosymrc4Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptosymrc4Vector::sub(self : Cryptosymrc4Vector, other : Cryptosymrc4Vector) -> Cryptosymrc4Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptosymrc4Vector::scale(self : Cryptosymrc4Vector, s : Double) -> Cryptosymrc4Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptosymrc4Vector::dot(self : Cryptosymrc4Vector, other : Cryptosymrc4Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptosymrc4Vector::norm(self : Cryptosymrc4Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptosymrc4Vector::normalize(self : Cryptosymrc4Vector) -> Cryptosymrc4Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptosymrc4Vector::dist(self : Cryptosymrc4Vector, other : Cryptosymrc4Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptosymrc4Vector::to_string(self : Cryptosymrc4Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptosymrc4Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_frame_make(size : Int) -> Cryptosymrc4Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Frame::len(self : Cryptosymrc4Frame) -> Int { self.size }

pub fn Cryptosymrc4Frame::get(self : Cryptosymrc4Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Frame::set(self : Cryptosymrc4Frame, i : Int, v : Double) -> Cryptosymrc4Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Frame::sum(self : Cryptosymrc4Frame) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Frame::mean(self : Cryptosymrc4Frame) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Frame::scale(self : Cryptosymrc4Frame, f : Double) -> Cryptosymrc4Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Frame::add(self : Cryptosymrc4Frame, other : Cryptosymrc4Frame) -> Cryptosymrc4Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Frame::copy(self : Cryptosymrc4Frame) -> Cryptosymrc4Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Frame::fill(self : Cryptosymrc4Frame, v : Double) -> Cryptosymrc4Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Frame::min(self : Cryptosymrc4Frame) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Frame::max(self : Cryptosymrc4Frame) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Frame::to_string(self : Cryptosymrc4Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_table_make(size : Int) -> Cryptosymrc4Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Table::len(self : Cryptosymrc4Table) -> Int { self.size }

pub fn Cryptosymrc4Table::get(self : Cryptosymrc4Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Table::set(self : Cryptosymrc4Table, i : Int, v : Double) -> Cryptosymrc4Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Table::sum(self : Cryptosymrc4Table) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Table::mean(self : Cryptosymrc4Table) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Table::scale(self : Cryptosymrc4Table, f : Double) -> Cryptosymrc4Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Table::add(self : Cryptosymrc4Table, other : Cryptosymrc4Table) -> Cryptosymrc4Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Table::copy(self : Cryptosymrc4Table) -> Cryptosymrc4Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Table::fill(self : Cryptosymrc4Table, v : Double) -> Cryptosymrc4Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Table::min(self : Cryptosymrc4Table) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Table::max(self : Cryptosymrc4Table) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Table::to_string(self : Cryptosymrc4Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_graphn_make(size : Int) -> Cryptosymrc4GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4GraphN::len(self : Cryptosymrc4GraphN) -> Int { self.size }

pub fn Cryptosymrc4GraphN::get(self : Cryptosymrc4GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4GraphN::set(self : Cryptosymrc4GraphN, i : Int, v : Double) -> Cryptosymrc4GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4GraphN::sum(self : Cryptosymrc4GraphN) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4GraphN::mean(self : Cryptosymrc4GraphN) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4GraphN::scale(self : Cryptosymrc4GraphN, f : Double) -> Cryptosymrc4GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4GraphN::add(self : Cryptosymrc4GraphN, other : Cryptosymrc4GraphN) -> Cryptosymrc4GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4GraphN::copy(self : Cryptosymrc4GraphN) -> Cryptosymrc4GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4GraphN::fill(self : Cryptosymrc4GraphN, v : Double) -> Cryptosymrc4GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4GraphN::min(self : Cryptosymrc4GraphN) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4GraphN::max(self : Cryptosymrc4GraphN) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4GraphN::to_string(self : Cryptosymrc4GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_node_make(size : Int) -> Cryptosymrc4Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Node::len(self : Cryptosymrc4Node) -> Int { self.size }

pub fn Cryptosymrc4Node::get(self : Cryptosymrc4Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Node::set(self : Cryptosymrc4Node, i : Int, v : Double) -> Cryptosymrc4Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Node::sum(self : Cryptosymrc4Node) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Node::mean(self : Cryptosymrc4Node) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Node::scale(self : Cryptosymrc4Node, f : Double) -> Cryptosymrc4Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Node::add(self : Cryptosymrc4Node, other : Cryptosymrc4Node) -> Cryptosymrc4Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Node::copy(self : Cryptosymrc4Node) -> Cryptosymrc4Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Node::fill(self : Cryptosymrc4Node, v : Double) -> Cryptosymrc4Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Node::min(self : Cryptosymrc4Node) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Node::max(self : Cryptosymrc4Node) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Node::to_string(self : Cryptosymrc4Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_edge_make(size : Int) -> Cryptosymrc4Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Edge::len(self : Cryptosymrc4Edge) -> Int { self.size }

pub fn Cryptosymrc4Edge::get(self : Cryptosymrc4Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Edge::set(self : Cryptosymrc4Edge, i : Int, v : Double) -> Cryptosymrc4Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Edge::sum(self : Cryptosymrc4Edge) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Edge::mean(self : Cryptosymrc4Edge) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Edge::scale(self : Cryptosymrc4Edge, f : Double) -> Cryptosymrc4Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Edge::add(self : Cryptosymrc4Edge, other : Cryptosymrc4Edge) -> Cryptosymrc4Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Edge::copy(self : Cryptosymrc4Edge) -> Cryptosymrc4Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Edge::fill(self : Cryptosymrc4Edge, v : Double) -> Cryptosymrc4Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Edge::min(self : Cryptosymrc4Edge) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Edge::max(self : Cryptosymrc4Edge) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Edge::to_string(self : Cryptosymrc4Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_path_make(size : Int) -> Cryptosymrc4Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Path::len(self : Cryptosymrc4Path) -> Int { self.size }

pub fn Cryptosymrc4Path::get(self : Cryptosymrc4Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Path::set(self : Cryptosymrc4Path, i : Int, v : Double) -> Cryptosymrc4Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Path::sum(self : Cryptosymrc4Path) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Path::mean(self : Cryptosymrc4Path) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Path::scale(self : Cryptosymrc4Path, f : Double) -> Cryptosymrc4Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Path::add(self : Cryptosymrc4Path, other : Cryptosymrc4Path) -> Cryptosymrc4Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Path::copy(self : Cryptosymrc4Path) -> Cryptosymrc4Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Path::fill(self : Cryptosymrc4Path, v : Double) -> Cryptosymrc4Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Path::min(self : Cryptosymrc4Path) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Path::max(self : Cryptosymrc4Path) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Path::to_string(self : Cryptosymrc4Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_cluster_make(size : Int) -> Cryptosymrc4Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Cluster::len(self : Cryptosymrc4Cluster) -> Int { self.size }

pub fn Cryptosymrc4Cluster::get(self : Cryptosymrc4Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Cluster::set(self : Cryptosymrc4Cluster, i : Int, v : Double) -> Cryptosymrc4Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Cluster::sum(self : Cryptosymrc4Cluster) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Cluster::mean(self : Cryptosymrc4Cluster) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Cluster::scale(self : Cryptosymrc4Cluster, f : Double) -> Cryptosymrc4Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Cluster::add(self : Cryptosymrc4Cluster, other : Cryptosymrc4Cluster) -> Cryptosymrc4Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Cluster::copy(self : Cryptosymrc4Cluster) -> Cryptosymrc4Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Cluster::fill(self : Cryptosymrc4Cluster, v : Double) -> Cryptosymrc4Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Cluster::min(self : Cryptosymrc4Cluster) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Cluster::max(self : Cryptosymrc4Cluster) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Cluster::to_string(self : Cryptosymrc4Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_model_make(size : Int) -> Cryptosymrc4Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Model::len(self : Cryptosymrc4Model) -> Int { self.size }

pub fn Cryptosymrc4Model::get(self : Cryptosymrc4Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Model::set(self : Cryptosymrc4Model, i : Int, v : Double) -> Cryptosymrc4Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Model::sum(self : Cryptosymrc4Model) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Model::mean(self : Cryptosymrc4Model) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Model::scale(self : Cryptosymrc4Model, f : Double) -> Cryptosymrc4Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Model::add(self : Cryptosymrc4Model, other : Cryptosymrc4Model) -> Cryptosymrc4Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Model::copy(self : Cryptosymrc4Model) -> Cryptosymrc4Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Model::fill(self : Cryptosymrc4Model, v : Double) -> Cryptosymrc4Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Model::min(self : Cryptosymrc4Model) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Model::max(self : Cryptosymrc4Model) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Model::to_string(self : Cryptosymrc4Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_layer_make(size : Int) -> Cryptosymrc4Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Layer::len(self : Cryptosymrc4Layer) -> Int { self.size }

pub fn Cryptosymrc4Layer::get(self : Cryptosymrc4Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Layer::set(self : Cryptosymrc4Layer, i : Int, v : Double) -> Cryptosymrc4Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Layer::sum(self : Cryptosymrc4Layer) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Layer::mean(self : Cryptosymrc4Layer) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Layer::scale(self : Cryptosymrc4Layer, f : Double) -> Cryptosymrc4Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Layer::add(self : Cryptosymrc4Layer, other : Cryptosymrc4Layer) -> Cryptosymrc4Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Layer::copy(self : Cryptosymrc4Layer) -> Cryptosymrc4Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Layer::fill(self : Cryptosymrc4Layer, v : Double) -> Cryptosymrc4Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Layer::min(self : Cryptosymrc4Layer) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Layer::max(self : Cryptosymrc4Layer) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Layer::to_string(self : Cryptosymrc4Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_buffer_make(size : Int) -> Cryptosymrc4Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Buffer::len(self : Cryptosymrc4Buffer) -> Int { self.size }

pub fn Cryptosymrc4Buffer::get(self : Cryptosymrc4Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Buffer::set(self : Cryptosymrc4Buffer, i : Int, v : Double) -> Cryptosymrc4Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Buffer::sum(self : Cryptosymrc4Buffer) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Buffer::mean(self : Cryptosymrc4Buffer) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Buffer::scale(self : Cryptosymrc4Buffer, f : Double) -> Cryptosymrc4Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Buffer::add(self : Cryptosymrc4Buffer, other : Cryptosymrc4Buffer) -> Cryptosymrc4Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Buffer::copy(self : Cryptosymrc4Buffer) -> Cryptosymrc4Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Buffer::fill(self : Cryptosymrc4Buffer, v : Double) -> Cryptosymrc4Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Buffer::min(self : Cryptosymrc4Buffer) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Buffer::max(self : Cryptosymrc4Buffer) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Buffer::to_string(self : Cryptosymrc4Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_cursor_make(size : Int) -> Cryptosymrc4Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Cursor::len(self : Cryptosymrc4Cursor) -> Int { self.size }

pub fn Cryptosymrc4Cursor::get(self : Cryptosymrc4Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Cursor::set(self : Cryptosymrc4Cursor, i : Int, v : Double) -> Cryptosymrc4Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Cursor::sum(self : Cryptosymrc4Cursor) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Cursor::mean(self : Cryptosymrc4Cursor) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Cursor::scale(self : Cryptosymrc4Cursor, f : Double) -> Cryptosymrc4Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Cursor::add(self : Cryptosymrc4Cursor, other : Cryptosymrc4Cursor) -> Cryptosymrc4Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Cursor::copy(self : Cryptosymrc4Cursor) -> Cryptosymrc4Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Cursor::fill(self : Cryptosymrc4Cursor, v : Double) -> Cryptosymrc4Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Cursor::min(self : Cryptosymrc4Cursor) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Cursor::max(self : Cryptosymrc4Cursor) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Cursor::to_string(self : Cryptosymrc4Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_view_make(size : Int) -> Cryptosymrc4View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4View::len(self : Cryptosymrc4View) -> Int { self.size }

pub fn Cryptosymrc4View::get(self : Cryptosymrc4View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4View::set(self : Cryptosymrc4View, i : Int, v : Double) -> Cryptosymrc4View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4View::sum(self : Cryptosymrc4View) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4View::mean(self : Cryptosymrc4View) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4View::scale(self : Cryptosymrc4View, f : Double) -> Cryptosymrc4View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4View::add(self : Cryptosymrc4View, other : Cryptosymrc4View) -> Cryptosymrc4View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4View::copy(self : Cryptosymrc4View) -> Cryptosymrc4View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4View::fill(self : Cryptosymrc4View, v : Double) -> Cryptosymrc4View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4View::min(self : Cryptosymrc4View) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4View::max(self : Cryptosymrc4View) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4View::to_string(self : Cryptosymrc4View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_range_make(size : Int) -> Cryptosymrc4Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Range::len(self : Cryptosymrc4Range) -> Int { self.size }

pub fn Cryptosymrc4Range::get(self : Cryptosymrc4Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Range::set(self : Cryptosymrc4Range, i : Int, v : Double) -> Cryptosymrc4Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Range::sum(self : Cryptosymrc4Range) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Range::mean(self : Cryptosymrc4Range) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Range::scale(self : Cryptosymrc4Range, f : Double) -> Cryptosymrc4Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Range::add(self : Cryptosymrc4Range, other : Cryptosymrc4Range) -> Cryptosymrc4Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Range::copy(self : Cryptosymrc4Range) -> Cryptosymrc4Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Range::fill(self : Cryptosymrc4Range, v : Double) -> Cryptosymrc4Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Range::min(self : Cryptosymrc4Range) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Range::max(self : Cryptosymrc4Range) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Range::to_string(self : Cryptosymrc4Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_slice_make(size : Int) -> Cryptosymrc4Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptosymrc4Slice::len(self : Cryptosymrc4Slice) -> Int { self.size }

pub fn Cryptosymrc4Slice::get(self : Cryptosymrc4Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptosymrc4Slice::set(self : Cryptosymrc4Slice, i : Int, v : Double) -> Cryptosymrc4Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Slice::sum(self : Cryptosymrc4Slice) -> Double { @_common.sum(self.data) }

pub fn Cryptosymrc4Slice::mean(self : Cryptosymrc4Slice) -> Double { @_common.mean(self.data) }

pub fn Cryptosymrc4Slice::scale(self : Cryptosymrc4Slice, f : Double) -> Cryptosymrc4Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Slice::add(self : Cryptosymrc4Slice, other : Cryptosymrc4Slice) -> Cryptosymrc4Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptosymrc4Slice::copy(self : Cryptosymrc4Slice) -> Cryptosymrc4Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Slice::fill(self : Cryptosymrc4Slice, v : Double) -> Cryptosymrc4Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptosymrc4Slice::min(self : Cryptosymrc4Slice) -> Double { @_common.min(self.data) }

pub fn Cryptosymrc4Slice::max(self : Cryptosymrc4Slice) -> Double { @_common.max(self.data) }

pub fn Cryptosymrc4Slice::to_string(self : Cryptosymrc4Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

