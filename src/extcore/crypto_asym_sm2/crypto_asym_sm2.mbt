///===
/// extcore/crypto_asym_sm2

pub(all) struct Cryptoasymsm2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_sm2_make_point(x : Double, y : Double) -> Cryptoasymsm2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_sm2_make_point3(x : Double, y : Double, z : Double) -> Cryptoasymsm2Point {
  { x, y, z, label: 0 }
}

pub fn Cryptoasymsm2Point::x(self : Cryptoasymsm2Point) -> Double { self.x }

pub fn Cryptoasymsm2Point::y(self : Cryptoasymsm2Point) -> Double { self.y }

pub fn Cryptoasymsm2Point::z(self : Cryptoasymsm2Point) -> Double { self.z }

pub fn Cryptoasymsm2Point::label(self : Cryptoasymsm2Point) -> Int { self.label }

pub fn Cryptoasymsm2Point::dist(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptoasymsm2Point::add(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptoasymsm2Point::sub(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptoasymsm2Point::scale(self : Cryptoasymsm2Point, s : Double) -> Cryptoasymsm2Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptoasymsm2Point::dot(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptoasymsm2Point::cross(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptoasymsm2Point::norm(self : Cryptoasymsm2Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptoasymsm2Point::normalize(self : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptoasymsm2Point::negate(self : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptoasymsm2Point::mid(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptoasymsm2Point::lerp(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point, t : Double) -> Cryptoasymsm2Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptoasymsm2Point::to_string(self : Cryptoasymsm2Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_sm2_make_series(vals : Array[Double], name : String) -> Cryptoasymsm2Series {
  { vals, name, meta: 0 }
}

pub fn Cryptoasymsm2Series::len(self : Cryptoasymsm2Series) -> Int { self.vals.length() }

pub fn Cryptoasymsm2Series::sum(self : Cryptoasymsm2Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptoasymsm2Series::mean(self : Cryptoasymsm2Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptoasymsm2Series::min(self : Cryptoasymsm2Series) -> Double { @_common.min(self.vals) }

pub fn Cryptoasymsm2Series::max(self : Cryptoasymsm2Series) -> Double { @_common.max(self.vals) }

pub fn Cryptoasymsm2Series::range(self : Cryptoasymsm2Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptoasymsm2Series::variance(self : Cryptoasymsm2Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptoasymsm2Series::std(self : Cryptoasymsm2Series) -> Double { @_common.std(self.vals) }

pub fn Cryptoasymsm2Series::median(self : Cryptoasymsm2Series) -> Double { @_common.median(self.vals) }

pub fn Cryptoasymsm2Series::scale(self : Cryptoasymsm2Series, f : Double) -> Cryptoasymsm2Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptoasymsm2Series::add(self : Cryptoasymsm2Series, other : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptoasymsm2Series::sub(self : Cryptoasymsm2Series, other : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptoasymsm2Series::normalize(self : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptoasymsm2Series::cumsum(self : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptoasymsm2Series::to_string(self : Cryptoasymsm2Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptoasymsm2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_sm2_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptoasymsm2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_sm2_matrix_identity(n : Int) -> Cryptoasymsm2Matrix {
  let m = crypto_asym_sm2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptoasymsm2Matrix::get(self : Cryptoasymsm2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptoasymsm2Matrix::transpose(self : Cryptoasymsm2Matrix) -> Cryptoasymsm2Matrix {
  let result = crypto_asym_sm2_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptoasymsm2Matrix::add(self : Cryptoasymsm2Matrix, other : Cryptoasymsm2Matrix) -> Cryptoasymsm2Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_sm2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptoasymsm2Matrix::scale(self : Cryptoasymsm2Matrix, s : Double) -> Cryptoasymsm2Matrix {
  let result = crypto_asym_sm2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptoasymsm2Matrix::multiply(self : Cryptoasymsm2Matrix, other : Cryptoasymsm2Matrix) -> Cryptoasymsm2Matrix {
  if self.cols != other.rows { return crypto_asym_sm2_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_sm2_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Cryptoasymsm2Matrix::trace(self : Cryptoasymsm2Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptoasymsm2Matrix::det(self : Cryptoasymsm2Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptoasymsm2Matrix::norm(self : Cryptoasymsm2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptoasymsm2Matrix::to_string(self : Cryptoasymsm2Matrix) -> String {
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

pub(all) struct Cryptoasymsm2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_sm2_make_vector(comps : Array[Double]) -> Cryptoasymsm2Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_sm2_vector_zero(dim : Int) -> Cryptoasymsm2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptoasymsm2Vector::add(self : Cryptoasymsm2Vector, other : Cryptoasymsm2Vector) -> Cryptoasymsm2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptoasymsm2Vector::sub(self : Cryptoasymsm2Vector, other : Cryptoasymsm2Vector) -> Cryptoasymsm2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptoasymsm2Vector::scale(self : Cryptoasymsm2Vector, s : Double) -> Cryptoasymsm2Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptoasymsm2Vector::dot(self : Cryptoasymsm2Vector, other : Cryptoasymsm2Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptoasymsm2Vector::norm(self : Cryptoasymsm2Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptoasymsm2Vector::normalize(self : Cryptoasymsm2Vector) -> Cryptoasymsm2Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptoasymsm2Vector::dist(self : Cryptoasymsm2Vector, other : Cryptoasymsm2Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptoasymsm2Vector::to_string(self : Cryptoasymsm2Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptoasymsm2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_frame_make(size : Int) -> Cryptoasymsm2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Frame::len(self : Cryptoasymsm2Frame) -> Int { self.size }

pub fn Cryptoasymsm2Frame::get(self : Cryptoasymsm2Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Frame::set(self : Cryptoasymsm2Frame, i : Int, v : Double) -> Cryptoasymsm2Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Frame::sum(self : Cryptoasymsm2Frame) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Frame::mean(self : Cryptoasymsm2Frame) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Frame::scale(self : Cryptoasymsm2Frame, f : Double) -> Cryptoasymsm2Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Frame::add(self : Cryptoasymsm2Frame, other : Cryptoasymsm2Frame) -> Cryptoasymsm2Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Frame::copy(self : Cryptoasymsm2Frame) -> Cryptoasymsm2Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Frame::fill(self : Cryptoasymsm2Frame, v : Double) -> Cryptoasymsm2Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Frame::min(self : Cryptoasymsm2Frame) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Frame::max(self : Cryptoasymsm2Frame) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Frame::to_string(self : Cryptoasymsm2Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_table_make(size : Int) -> Cryptoasymsm2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Table::len(self : Cryptoasymsm2Table) -> Int { self.size }

pub fn Cryptoasymsm2Table::get(self : Cryptoasymsm2Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Table::set(self : Cryptoasymsm2Table, i : Int, v : Double) -> Cryptoasymsm2Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Table::sum(self : Cryptoasymsm2Table) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Table::mean(self : Cryptoasymsm2Table) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Table::scale(self : Cryptoasymsm2Table, f : Double) -> Cryptoasymsm2Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Table::add(self : Cryptoasymsm2Table, other : Cryptoasymsm2Table) -> Cryptoasymsm2Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Table::copy(self : Cryptoasymsm2Table) -> Cryptoasymsm2Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Table::fill(self : Cryptoasymsm2Table, v : Double) -> Cryptoasymsm2Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Table::min(self : Cryptoasymsm2Table) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Table::max(self : Cryptoasymsm2Table) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Table::to_string(self : Cryptoasymsm2Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_graphn_make(size : Int) -> Cryptoasymsm2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2GraphN::len(self : Cryptoasymsm2GraphN) -> Int { self.size }

pub fn Cryptoasymsm2GraphN::get(self : Cryptoasymsm2GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2GraphN::set(self : Cryptoasymsm2GraphN, i : Int, v : Double) -> Cryptoasymsm2GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2GraphN::sum(self : Cryptoasymsm2GraphN) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2GraphN::mean(self : Cryptoasymsm2GraphN) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2GraphN::scale(self : Cryptoasymsm2GraphN, f : Double) -> Cryptoasymsm2GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2GraphN::add(self : Cryptoasymsm2GraphN, other : Cryptoasymsm2GraphN) -> Cryptoasymsm2GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2GraphN::copy(self : Cryptoasymsm2GraphN) -> Cryptoasymsm2GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2GraphN::fill(self : Cryptoasymsm2GraphN, v : Double) -> Cryptoasymsm2GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2GraphN::min(self : Cryptoasymsm2GraphN) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2GraphN::max(self : Cryptoasymsm2GraphN) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2GraphN::to_string(self : Cryptoasymsm2GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_node_make(size : Int) -> Cryptoasymsm2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Node::len(self : Cryptoasymsm2Node) -> Int { self.size }

pub fn Cryptoasymsm2Node::get(self : Cryptoasymsm2Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Node::set(self : Cryptoasymsm2Node, i : Int, v : Double) -> Cryptoasymsm2Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Node::sum(self : Cryptoasymsm2Node) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Node::mean(self : Cryptoasymsm2Node) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Node::scale(self : Cryptoasymsm2Node, f : Double) -> Cryptoasymsm2Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Node::add(self : Cryptoasymsm2Node, other : Cryptoasymsm2Node) -> Cryptoasymsm2Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Node::copy(self : Cryptoasymsm2Node) -> Cryptoasymsm2Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Node::fill(self : Cryptoasymsm2Node, v : Double) -> Cryptoasymsm2Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Node::min(self : Cryptoasymsm2Node) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Node::max(self : Cryptoasymsm2Node) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Node::to_string(self : Cryptoasymsm2Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_edge_make(size : Int) -> Cryptoasymsm2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Edge::len(self : Cryptoasymsm2Edge) -> Int { self.size }

pub fn Cryptoasymsm2Edge::get(self : Cryptoasymsm2Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Edge::set(self : Cryptoasymsm2Edge, i : Int, v : Double) -> Cryptoasymsm2Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Edge::sum(self : Cryptoasymsm2Edge) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Edge::mean(self : Cryptoasymsm2Edge) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Edge::scale(self : Cryptoasymsm2Edge, f : Double) -> Cryptoasymsm2Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Edge::add(self : Cryptoasymsm2Edge, other : Cryptoasymsm2Edge) -> Cryptoasymsm2Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Edge::copy(self : Cryptoasymsm2Edge) -> Cryptoasymsm2Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Edge::fill(self : Cryptoasymsm2Edge, v : Double) -> Cryptoasymsm2Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Edge::min(self : Cryptoasymsm2Edge) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Edge::max(self : Cryptoasymsm2Edge) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Edge::to_string(self : Cryptoasymsm2Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_path_make(size : Int) -> Cryptoasymsm2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Path::len(self : Cryptoasymsm2Path) -> Int { self.size }

pub fn Cryptoasymsm2Path::get(self : Cryptoasymsm2Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Path::set(self : Cryptoasymsm2Path, i : Int, v : Double) -> Cryptoasymsm2Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Path::sum(self : Cryptoasymsm2Path) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Path::mean(self : Cryptoasymsm2Path) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Path::scale(self : Cryptoasymsm2Path, f : Double) -> Cryptoasymsm2Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Path::add(self : Cryptoasymsm2Path, other : Cryptoasymsm2Path) -> Cryptoasymsm2Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Path::copy(self : Cryptoasymsm2Path) -> Cryptoasymsm2Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Path::fill(self : Cryptoasymsm2Path, v : Double) -> Cryptoasymsm2Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Path::min(self : Cryptoasymsm2Path) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Path::max(self : Cryptoasymsm2Path) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Path::to_string(self : Cryptoasymsm2Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_cluster_make(size : Int) -> Cryptoasymsm2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Cluster::len(self : Cryptoasymsm2Cluster) -> Int { self.size }

pub fn Cryptoasymsm2Cluster::get(self : Cryptoasymsm2Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Cluster::set(self : Cryptoasymsm2Cluster, i : Int, v : Double) -> Cryptoasymsm2Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Cluster::sum(self : Cryptoasymsm2Cluster) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Cluster::mean(self : Cryptoasymsm2Cluster) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Cluster::scale(self : Cryptoasymsm2Cluster, f : Double) -> Cryptoasymsm2Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Cluster::add(self : Cryptoasymsm2Cluster, other : Cryptoasymsm2Cluster) -> Cryptoasymsm2Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Cluster::copy(self : Cryptoasymsm2Cluster) -> Cryptoasymsm2Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Cluster::fill(self : Cryptoasymsm2Cluster, v : Double) -> Cryptoasymsm2Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Cluster::min(self : Cryptoasymsm2Cluster) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Cluster::max(self : Cryptoasymsm2Cluster) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Cluster::to_string(self : Cryptoasymsm2Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_model_make(size : Int) -> Cryptoasymsm2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Model::len(self : Cryptoasymsm2Model) -> Int { self.size }

pub fn Cryptoasymsm2Model::get(self : Cryptoasymsm2Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Model::set(self : Cryptoasymsm2Model, i : Int, v : Double) -> Cryptoasymsm2Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Model::sum(self : Cryptoasymsm2Model) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Model::mean(self : Cryptoasymsm2Model) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Model::scale(self : Cryptoasymsm2Model, f : Double) -> Cryptoasymsm2Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Model::add(self : Cryptoasymsm2Model, other : Cryptoasymsm2Model) -> Cryptoasymsm2Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Model::copy(self : Cryptoasymsm2Model) -> Cryptoasymsm2Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Model::fill(self : Cryptoasymsm2Model, v : Double) -> Cryptoasymsm2Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Model::min(self : Cryptoasymsm2Model) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Model::max(self : Cryptoasymsm2Model) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Model::to_string(self : Cryptoasymsm2Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_layer_make(size : Int) -> Cryptoasymsm2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Layer::len(self : Cryptoasymsm2Layer) -> Int { self.size }

pub fn Cryptoasymsm2Layer::get(self : Cryptoasymsm2Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Layer::set(self : Cryptoasymsm2Layer, i : Int, v : Double) -> Cryptoasymsm2Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Layer::sum(self : Cryptoasymsm2Layer) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Layer::mean(self : Cryptoasymsm2Layer) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Layer::scale(self : Cryptoasymsm2Layer, f : Double) -> Cryptoasymsm2Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Layer::add(self : Cryptoasymsm2Layer, other : Cryptoasymsm2Layer) -> Cryptoasymsm2Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Layer::copy(self : Cryptoasymsm2Layer) -> Cryptoasymsm2Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Layer::fill(self : Cryptoasymsm2Layer, v : Double) -> Cryptoasymsm2Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Layer::min(self : Cryptoasymsm2Layer) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Layer::max(self : Cryptoasymsm2Layer) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Layer::to_string(self : Cryptoasymsm2Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_buffer_make(size : Int) -> Cryptoasymsm2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Buffer::len(self : Cryptoasymsm2Buffer) -> Int { self.size }

pub fn Cryptoasymsm2Buffer::get(self : Cryptoasymsm2Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Buffer::set(self : Cryptoasymsm2Buffer, i : Int, v : Double) -> Cryptoasymsm2Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Buffer::sum(self : Cryptoasymsm2Buffer) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Buffer::mean(self : Cryptoasymsm2Buffer) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Buffer::scale(self : Cryptoasymsm2Buffer, f : Double) -> Cryptoasymsm2Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Buffer::add(self : Cryptoasymsm2Buffer, other : Cryptoasymsm2Buffer) -> Cryptoasymsm2Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Buffer::copy(self : Cryptoasymsm2Buffer) -> Cryptoasymsm2Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Buffer::fill(self : Cryptoasymsm2Buffer, v : Double) -> Cryptoasymsm2Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Buffer::min(self : Cryptoasymsm2Buffer) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Buffer::max(self : Cryptoasymsm2Buffer) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Buffer::to_string(self : Cryptoasymsm2Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_cursor_make(size : Int) -> Cryptoasymsm2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Cursor::len(self : Cryptoasymsm2Cursor) -> Int { self.size }

pub fn Cryptoasymsm2Cursor::get(self : Cryptoasymsm2Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Cursor::set(self : Cryptoasymsm2Cursor, i : Int, v : Double) -> Cryptoasymsm2Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Cursor::sum(self : Cryptoasymsm2Cursor) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Cursor::mean(self : Cryptoasymsm2Cursor) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Cursor::scale(self : Cryptoasymsm2Cursor, f : Double) -> Cryptoasymsm2Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Cursor::add(self : Cryptoasymsm2Cursor, other : Cryptoasymsm2Cursor) -> Cryptoasymsm2Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Cursor::copy(self : Cryptoasymsm2Cursor) -> Cryptoasymsm2Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Cursor::fill(self : Cryptoasymsm2Cursor, v : Double) -> Cryptoasymsm2Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Cursor::min(self : Cryptoasymsm2Cursor) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Cursor::max(self : Cryptoasymsm2Cursor) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Cursor::to_string(self : Cryptoasymsm2Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_view_make(size : Int) -> Cryptoasymsm2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2View::len(self : Cryptoasymsm2View) -> Int { self.size }

pub fn Cryptoasymsm2View::get(self : Cryptoasymsm2View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2View::set(self : Cryptoasymsm2View, i : Int, v : Double) -> Cryptoasymsm2View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2View::sum(self : Cryptoasymsm2View) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2View::mean(self : Cryptoasymsm2View) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2View::scale(self : Cryptoasymsm2View, f : Double) -> Cryptoasymsm2View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2View::add(self : Cryptoasymsm2View, other : Cryptoasymsm2View) -> Cryptoasymsm2View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2View::copy(self : Cryptoasymsm2View) -> Cryptoasymsm2View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2View::fill(self : Cryptoasymsm2View, v : Double) -> Cryptoasymsm2View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2View::min(self : Cryptoasymsm2View) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2View::max(self : Cryptoasymsm2View) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2View::to_string(self : Cryptoasymsm2View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_range_make(size : Int) -> Cryptoasymsm2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Range::len(self : Cryptoasymsm2Range) -> Int { self.size }

pub fn Cryptoasymsm2Range::get(self : Cryptoasymsm2Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Range::set(self : Cryptoasymsm2Range, i : Int, v : Double) -> Cryptoasymsm2Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Range::sum(self : Cryptoasymsm2Range) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Range::mean(self : Cryptoasymsm2Range) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Range::scale(self : Cryptoasymsm2Range, f : Double) -> Cryptoasymsm2Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Range::add(self : Cryptoasymsm2Range, other : Cryptoasymsm2Range) -> Cryptoasymsm2Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Range::copy(self : Cryptoasymsm2Range) -> Cryptoasymsm2Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Range::fill(self : Cryptoasymsm2Range, v : Double) -> Cryptoasymsm2Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Range::min(self : Cryptoasymsm2Range) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Range::max(self : Cryptoasymsm2Range) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Range::to_string(self : Cryptoasymsm2Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_slice_make(size : Int) -> Cryptoasymsm2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptoasymsm2Slice::len(self : Cryptoasymsm2Slice) -> Int { self.size }

pub fn Cryptoasymsm2Slice::get(self : Cryptoasymsm2Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptoasymsm2Slice::set(self : Cryptoasymsm2Slice, i : Int, v : Double) -> Cryptoasymsm2Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Slice::sum(self : Cryptoasymsm2Slice) -> Double { @_common.sum(self.data) }

pub fn Cryptoasymsm2Slice::mean(self : Cryptoasymsm2Slice) -> Double { @_common.mean(self.data) }

pub fn Cryptoasymsm2Slice::scale(self : Cryptoasymsm2Slice, f : Double) -> Cryptoasymsm2Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Slice::add(self : Cryptoasymsm2Slice, other : Cryptoasymsm2Slice) -> Cryptoasymsm2Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptoasymsm2Slice::copy(self : Cryptoasymsm2Slice) -> Cryptoasymsm2Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Slice::fill(self : Cryptoasymsm2Slice, v : Double) -> Cryptoasymsm2Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptoasymsm2Slice::min(self : Cryptoasymsm2Slice) -> Double { @_common.min(self.data) }

pub fn Cryptoasymsm2Slice::max(self : Cryptoasymsm2Slice) -> Double { @_common.max(self.data) }

pub fn Cryptoasymsm2Slice::to_string(self : Cryptoasymsm2Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

