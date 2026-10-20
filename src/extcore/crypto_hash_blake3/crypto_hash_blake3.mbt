///===
/// extcore/crypto_hash_blake3

pub(all) struct Cryptohashblake3Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_blake3_make_point(x : Double, y : Double) -> Cryptohashblake3Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_blake3_make_point3(x : Double, y : Double, z : Double) -> Cryptohashblake3Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashblake3Point::x(self : Cryptohashblake3Point) -> Double { self.x }

pub fn Cryptohashblake3Point::y(self : Cryptohashblake3Point) -> Double { self.y }

pub fn Cryptohashblake3Point::z(self : Cryptohashblake3Point) -> Double { self.z }

pub fn Cryptohashblake3Point::label(self : Cryptohashblake3Point) -> Int { self.label }

pub fn Cryptohashblake3Point::dist(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashblake3Point::add(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashblake3Point::sub(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashblake3Point::scale(self : Cryptohashblake3Point, s : Double) -> Cryptohashblake3Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashblake3Point::dot(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashblake3Point::cross(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashblake3Point::norm(self : Cryptohashblake3Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashblake3Point::normalize(self : Cryptohashblake3Point) -> Cryptohashblake3Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashblake3Point::negate(self : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashblake3Point::mid(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashblake3Point::lerp(self : Cryptohashblake3Point, other : Cryptohashblake3Point, t : Double) -> Cryptohashblake3Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashblake3Point::to_string(self : Cryptohashblake3Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashblake3Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_blake3_make_series(vals : Array[Double], name : String) -> Cryptohashblake3Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashblake3Series::len(self : Cryptohashblake3Series) -> Int { self.vals.length() }

pub fn Cryptohashblake3Series::sum(self : Cryptohashblake3Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashblake3Series::mean(self : Cryptohashblake3Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashblake3Series::min(self : Cryptohashblake3Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashblake3Series::max(self : Cryptohashblake3Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashblake3Series::range(self : Cryptohashblake3Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashblake3Series::variance(self : Cryptohashblake3Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashblake3Series::std(self : Cryptohashblake3Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashblake3Series::median(self : Cryptohashblake3Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashblake3Series::scale(self : Cryptohashblake3Series, f : Double) -> Cryptohashblake3Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashblake3Series::add(self : Cryptohashblake3Series, other : Cryptohashblake3Series) -> Cryptohashblake3Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashblake3Series::sub(self : Cryptohashblake3Series, other : Cryptohashblake3Series) -> Cryptohashblake3Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashblake3Series::normalize(self : Cryptohashblake3Series) -> Cryptohashblake3Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashblake3Series::cumsum(self : Cryptohashblake3Series) -> Cryptohashblake3Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashblake3Series::to_string(self : Cryptohashblake3Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashblake3Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_blake3_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashblake3Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_blake3_matrix_identity(n : Int) -> Cryptohashblake3Matrix {
  let m = crypto_hash_blake3_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashblake3Matrix::get(self : Cryptohashblake3Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashblake3Matrix::transpose(self : Cryptohashblake3Matrix) -> Cryptohashblake3Matrix {
  let result = crypto_hash_blake3_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashblake3Matrix::add(self : Cryptohashblake3Matrix, other : Cryptohashblake3Matrix) -> Cryptohashblake3Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_blake3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashblake3Matrix::scale(self : Cryptohashblake3Matrix, s : Double) -> Cryptohashblake3Matrix {
  let result = crypto_hash_blake3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashblake3Matrix::multiply(self : Cryptohashblake3Matrix, other : Cryptohashblake3Matrix) -> Cryptohashblake3Matrix {
  if self.cols != other.rows { return crypto_hash_blake3_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_blake3_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptohashblake3Matrix::trace(self : Cryptohashblake3Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashblake3Matrix::det(self : Cryptohashblake3Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashblake3Matrix::norm(self : Cryptohashblake3Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashblake3Matrix::to_string(self : Cryptohashblake3Matrix) -> String {
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

pub(all) struct Cryptohashblake3Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_blake3_make_vector(comps : Array[Double]) -> Cryptohashblake3Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_blake3_vector_zero(dim : Int) -> Cryptohashblake3Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashblake3Vector::add(self : Cryptohashblake3Vector, other : Cryptohashblake3Vector) -> Cryptohashblake3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashblake3Vector::sub(self : Cryptohashblake3Vector, other : Cryptohashblake3Vector) -> Cryptohashblake3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashblake3Vector::scale(self : Cryptohashblake3Vector, s : Double) -> Cryptohashblake3Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashblake3Vector::dot(self : Cryptohashblake3Vector, other : Cryptohashblake3Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashblake3Vector::norm(self : Cryptohashblake3Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashblake3Vector::normalize(self : Cryptohashblake3Vector) -> Cryptohashblake3Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashblake3Vector::dist(self : Cryptohashblake3Vector, other : Cryptohashblake3Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashblake3Vector::to_string(self : Cryptohashblake3Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashblake3Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_frame_make(size : Int) -> Cryptohashblake3Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Frame::len(self : Cryptohashblake3Frame) -> Int { self.size }

pub fn Cryptohashblake3Frame::get(self : Cryptohashblake3Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Frame::set(self : Cryptohashblake3Frame, i : Int, v : Double) -> Cryptohashblake3Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Frame::sum(self : Cryptohashblake3Frame) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Frame::mean(self : Cryptohashblake3Frame) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Frame::scale(self : Cryptohashblake3Frame, f : Double) -> Cryptohashblake3Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Frame::add(self : Cryptohashblake3Frame, other : Cryptohashblake3Frame) -> Cryptohashblake3Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Frame::copy(self : Cryptohashblake3Frame) -> Cryptohashblake3Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Frame::fill(self : Cryptohashblake3Frame, v : Double) -> Cryptohashblake3Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Frame::min(self : Cryptohashblake3Frame) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Frame::max(self : Cryptohashblake3Frame) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Frame::to_string(self : Cryptohashblake3Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_table_make(size : Int) -> Cryptohashblake3Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Table::len(self : Cryptohashblake3Table) -> Int { self.size }

pub fn Cryptohashblake3Table::get(self : Cryptohashblake3Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Table::set(self : Cryptohashblake3Table, i : Int, v : Double) -> Cryptohashblake3Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Table::sum(self : Cryptohashblake3Table) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Table::mean(self : Cryptohashblake3Table) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Table::scale(self : Cryptohashblake3Table, f : Double) -> Cryptohashblake3Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Table::add(self : Cryptohashblake3Table, other : Cryptohashblake3Table) -> Cryptohashblake3Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Table::copy(self : Cryptohashblake3Table) -> Cryptohashblake3Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Table::fill(self : Cryptohashblake3Table, v : Double) -> Cryptohashblake3Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Table::min(self : Cryptohashblake3Table) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Table::max(self : Cryptohashblake3Table) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Table::to_string(self : Cryptohashblake3Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_graphn_make(size : Int) -> Cryptohashblake3GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3GraphN::len(self : Cryptohashblake3GraphN) -> Int { self.size }

pub fn Cryptohashblake3GraphN::get(self : Cryptohashblake3GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3GraphN::set(self : Cryptohashblake3GraphN, i : Int, v : Double) -> Cryptohashblake3GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3GraphN::sum(self : Cryptohashblake3GraphN) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3GraphN::mean(self : Cryptohashblake3GraphN) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3GraphN::scale(self : Cryptohashblake3GraphN, f : Double) -> Cryptohashblake3GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3GraphN::add(self : Cryptohashblake3GraphN, other : Cryptohashblake3GraphN) -> Cryptohashblake3GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3GraphN::copy(self : Cryptohashblake3GraphN) -> Cryptohashblake3GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3GraphN::fill(self : Cryptohashblake3GraphN, v : Double) -> Cryptohashblake3GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3GraphN::min(self : Cryptohashblake3GraphN) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3GraphN::max(self : Cryptohashblake3GraphN) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3GraphN::to_string(self : Cryptohashblake3GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_node_make(size : Int) -> Cryptohashblake3Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Node::len(self : Cryptohashblake3Node) -> Int { self.size }

pub fn Cryptohashblake3Node::get(self : Cryptohashblake3Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Node::set(self : Cryptohashblake3Node, i : Int, v : Double) -> Cryptohashblake3Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Node::sum(self : Cryptohashblake3Node) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Node::mean(self : Cryptohashblake3Node) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Node::scale(self : Cryptohashblake3Node, f : Double) -> Cryptohashblake3Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Node::add(self : Cryptohashblake3Node, other : Cryptohashblake3Node) -> Cryptohashblake3Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Node::copy(self : Cryptohashblake3Node) -> Cryptohashblake3Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Node::fill(self : Cryptohashblake3Node, v : Double) -> Cryptohashblake3Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Node::min(self : Cryptohashblake3Node) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Node::max(self : Cryptohashblake3Node) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Node::to_string(self : Cryptohashblake3Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_edge_make(size : Int) -> Cryptohashblake3Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Edge::len(self : Cryptohashblake3Edge) -> Int { self.size }

pub fn Cryptohashblake3Edge::get(self : Cryptohashblake3Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Edge::set(self : Cryptohashblake3Edge, i : Int, v : Double) -> Cryptohashblake3Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Edge::sum(self : Cryptohashblake3Edge) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Edge::mean(self : Cryptohashblake3Edge) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Edge::scale(self : Cryptohashblake3Edge, f : Double) -> Cryptohashblake3Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Edge::add(self : Cryptohashblake3Edge, other : Cryptohashblake3Edge) -> Cryptohashblake3Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Edge::copy(self : Cryptohashblake3Edge) -> Cryptohashblake3Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Edge::fill(self : Cryptohashblake3Edge, v : Double) -> Cryptohashblake3Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Edge::min(self : Cryptohashblake3Edge) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Edge::max(self : Cryptohashblake3Edge) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Edge::to_string(self : Cryptohashblake3Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_path_make(size : Int) -> Cryptohashblake3Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Path::len(self : Cryptohashblake3Path) -> Int { self.size }

pub fn Cryptohashblake3Path::get(self : Cryptohashblake3Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Path::set(self : Cryptohashblake3Path, i : Int, v : Double) -> Cryptohashblake3Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Path::sum(self : Cryptohashblake3Path) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Path::mean(self : Cryptohashblake3Path) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Path::scale(self : Cryptohashblake3Path, f : Double) -> Cryptohashblake3Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Path::add(self : Cryptohashblake3Path, other : Cryptohashblake3Path) -> Cryptohashblake3Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Path::copy(self : Cryptohashblake3Path) -> Cryptohashblake3Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Path::fill(self : Cryptohashblake3Path, v : Double) -> Cryptohashblake3Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Path::min(self : Cryptohashblake3Path) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Path::max(self : Cryptohashblake3Path) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Path::to_string(self : Cryptohashblake3Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_cluster_make(size : Int) -> Cryptohashblake3Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Cluster::len(self : Cryptohashblake3Cluster) -> Int { self.size }

pub fn Cryptohashblake3Cluster::get(self : Cryptohashblake3Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Cluster::set(self : Cryptohashblake3Cluster, i : Int, v : Double) -> Cryptohashblake3Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Cluster::sum(self : Cryptohashblake3Cluster) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Cluster::mean(self : Cryptohashblake3Cluster) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Cluster::scale(self : Cryptohashblake3Cluster, f : Double) -> Cryptohashblake3Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Cluster::add(self : Cryptohashblake3Cluster, other : Cryptohashblake3Cluster) -> Cryptohashblake3Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Cluster::copy(self : Cryptohashblake3Cluster) -> Cryptohashblake3Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Cluster::fill(self : Cryptohashblake3Cluster, v : Double) -> Cryptohashblake3Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Cluster::min(self : Cryptohashblake3Cluster) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Cluster::max(self : Cryptohashblake3Cluster) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Cluster::to_string(self : Cryptohashblake3Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_model_make(size : Int) -> Cryptohashblake3Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Model::len(self : Cryptohashblake3Model) -> Int { self.size }

pub fn Cryptohashblake3Model::get(self : Cryptohashblake3Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Model::set(self : Cryptohashblake3Model, i : Int, v : Double) -> Cryptohashblake3Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Model::sum(self : Cryptohashblake3Model) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Model::mean(self : Cryptohashblake3Model) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Model::scale(self : Cryptohashblake3Model, f : Double) -> Cryptohashblake3Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Model::add(self : Cryptohashblake3Model, other : Cryptohashblake3Model) -> Cryptohashblake3Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Model::copy(self : Cryptohashblake3Model) -> Cryptohashblake3Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Model::fill(self : Cryptohashblake3Model, v : Double) -> Cryptohashblake3Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Model::min(self : Cryptohashblake3Model) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Model::max(self : Cryptohashblake3Model) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Model::to_string(self : Cryptohashblake3Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_layer_make(size : Int) -> Cryptohashblake3Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Layer::len(self : Cryptohashblake3Layer) -> Int { self.size }

pub fn Cryptohashblake3Layer::get(self : Cryptohashblake3Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Layer::set(self : Cryptohashblake3Layer, i : Int, v : Double) -> Cryptohashblake3Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Layer::sum(self : Cryptohashblake3Layer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Layer::mean(self : Cryptohashblake3Layer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Layer::scale(self : Cryptohashblake3Layer, f : Double) -> Cryptohashblake3Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Layer::add(self : Cryptohashblake3Layer, other : Cryptohashblake3Layer) -> Cryptohashblake3Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Layer::copy(self : Cryptohashblake3Layer) -> Cryptohashblake3Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Layer::fill(self : Cryptohashblake3Layer, v : Double) -> Cryptohashblake3Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Layer::min(self : Cryptohashblake3Layer) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Layer::max(self : Cryptohashblake3Layer) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Layer::to_string(self : Cryptohashblake3Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_buffer_make(size : Int) -> Cryptohashblake3Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Buffer::len(self : Cryptohashblake3Buffer) -> Int { self.size }

pub fn Cryptohashblake3Buffer::get(self : Cryptohashblake3Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Buffer::set(self : Cryptohashblake3Buffer, i : Int, v : Double) -> Cryptohashblake3Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Buffer::sum(self : Cryptohashblake3Buffer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Buffer::mean(self : Cryptohashblake3Buffer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Buffer::scale(self : Cryptohashblake3Buffer, f : Double) -> Cryptohashblake3Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Buffer::add(self : Cryptohashblake3Buffer, other : Cryptohashblake3Buffer) -> Cryptohashblake3Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Buffer::copy(self : Cryptohashblake3Buffer) -> Cryptohashblake3Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Buffer::fill(self : Cryptohashblake3Buffer, v : Double) -> Cryptohashblake3Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Buffer::min(self : Cryptohashblake3Buffer) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Buffer::max(self : Cryptohashblake3Buffer) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Buffer::to_string(self : Cryptohashblake3Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_cursor_make(size : Int) -> Cryptohashblake3Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Cursor::len(self : Cryptohashblake3Cursor) -> Int { self.size }

pub fn Cryptohashblake3Cursor::get(self : Cryptohashblake3Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Cursor::set(self : Cryptohashblake3Cursor, i : Int, v : Double) -> Cryptohashblake3Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Cursor::sum(self : Cryptohashblake3Cursor) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Cursor::mean(self : Cryptohashblake3Cursor) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Cursor::scale(self : Cryptohashblake3Cursor, f : Double) -> Cryptohashblake3Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Cursor::add(self : Cryptohashblake3Cursor, other : Cryptohashblake3Cursor) -> Cryptohashblake3Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Cursor::copy(self : Cryptohashblake3Cursor) -> Cryptohashblake3Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Cursor::fill(self : Cryptohashblake3Cursor, v : Double) -> Cryptohashblake3Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Cursor::min(self : Cryptohashblake3Cursor) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Cursor::max(self : Cryptohashblake3Cursor) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Cursor::to_string(self : Cryptohashblake3Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_view_make(size : Int) -> Cryptohashblake3View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3View::len(self : Cryptohashblake3View) -> Int { self.size }

pub fn Cryptohashblake3View::get(self : Cryptohashblake3View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3View::set(self : Cryptohashblake3View, i : Int, v : Double) -> Cryptohashblake3View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3View::sum(self : Cryptohashblake3View) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3View::mean(self : Cryptohashblake3View) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3View::scale(self : Cryptohashblake3View, f : Double) -> Cryptohashblake3View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3View::add(self : Cryptohashblake3View, other : Cryptohashblake3View) -> Cryptohashblake3View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3View::copy(self : Cryptohashblake3View) -> Cryptohashblake3View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3View::fill(self : Cryptohashblake3View, v : Double) -> Cryptohashblake3View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3View::min(self : Cryptohashblake3View) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3View::max(self : Cryptohashblake3View) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3View::to_string(self : Cryptohashblake3View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_range_make(size : Int) -> Cryptohashblake3Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Range::len(self : Cryptohashblake3Range) -> Int { self.size }

pub fn Cryptohashblake3Range::get(self : Cryptohashblake3Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Range::set(self : Cryptohashblake3Range, i : Int, v : Double) -> Cryptohashblake3Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Range::sum(self : Cryptohashblake3Range) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Range::mean(self : Cryptohashblake3Range) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Range::scale(self : Cryptohashblake3Range, f : Double) -> Cryptohashblake3Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Range::add(self : Cryptohashblake3Range, other : Cryptohashblake3Range) -> Cryptohashblake3Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Range::copy(self : Cryptohashblake3Range) -> Cryptohashblake3Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Range::fill(self : Cryptohashblake3Range, v : Double) -> Cryptohashblake3Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Range::min(self : Cryptohashblake3Range) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Range::max(self : Cryptohashblake3Range) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Range::to_string(self : Cryptohashblake3Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_slice_make(size : Int) -> Cryptohashblake3Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake3Slice::len(self : Cryptohashblake3Slice) -> Int { self.size }

pub fn Cryptohashblake3Slice::get(self : Cryptohashblake3Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake3Slice::set(self : Cryptohashblake3Slice, i : Int, v : Double) -> Cryptohashblake3Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Slice::sum(self : Cryptohashblake3Slice) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake3Slice::mean(self : Cryptohashblake3Slice) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake3Slice::scale(self : Cryptohashblake3Slice, f : Double) -> Cryptohashblake3Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Slice::add(self : Cryptohashblake3Slice, other : Cryptohashblake3Slice) -> Cryptohashblake3Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake3Slice::copy(self : Cryptohashblake3Slice) -> Cryptohashblake3Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Slice::fill(self : Cryptohashblake3Slice, v : Double) -> Cryptohashblake3Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake3Slice::min(self : Cryptohashblake3Slice) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake3Slice::max(self : Cryptohashblake3Slice) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake3Slice::to_string(self : Cryptohashblake3Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

