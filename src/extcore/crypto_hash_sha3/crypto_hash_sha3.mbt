///===
/// extcore/crypto_hash_sha3

pub(all) struct Cryptohashsha3Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha3_make_point(x : Double, y : Double) -> Cryptohashsha3Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha3_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha3Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashsha3Point::x(self : Cryptohashsha3Point) -> Double { self.x }

pub fn Cryptohashsha3Point::y(self : Cryptohashsha3Point) -> Double { self.y }

pub fn Cryptohashsha3Point::z(self : Cryptohashsha3Point) -> Double { self.z }

pub fn Cryptohashsha3Point::label(self : Cryptohashsha3Point) -> Int { self.label }

pub fn Cryptohashsha3Point::dist(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashsha3Point::add(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashsha3Point::sub(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashsha3Point::scale(self : Cryptohashsha3Point, s : Double) -> Cryptohashsha3Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashsha3Point::dot(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashsha3Point::cross(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashsha3Point::norm(self : Cryptohashsha3Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashsha3Point::normalize(self : Cryptohashsha3Point) -> Cryptohashsha3Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha3Point::negate(self : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashsha3Point::mid(self : Cryptohashsha3Point, other : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashsha3Point::lerp(self : Cryptohashsha3Point, other : Cryptohashsha3Point, t : Double) -> Cryptohashsha3Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashsha3Point::to_string(self : Cryptohashsha3Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashsha3Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha3_make_series(vals : Array[Double], name : String) -> Cryptohashsha3Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashsha3Series::len(self : Cryptohashsha3Series) -> Int { self.vals.length() }

pub fn Cryptohashsha3Series::sum(self : Cryptohashsha3Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashsha3Series::mean(self : Cryptohashsha3Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashsha3Series::min(self : Cryptohashsha3Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashsha3Series::max(self : Cryptohashsha3Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashsha3Series::range(self : Cryptohashsha3Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashsha3Series::variance(self : Cryptohashsha3Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashsha3Series::std(self : Cryptohashsha3Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashsha3Series::median(self : Cryptohashsha3Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashsha3Series::scale(self : Cryptohashsha3Series, f : Double) -> Cryptohashsha3Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashsha3Series::add(self : Cryptohashsha3Series, other : Cryptohashsha3Series) -> Cryptohashsha3Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashsha3Series::sub(self : Cryptohashsha3Series, other : Cryptohashsha3Series) -> Cryptohashsha3Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashsha3Series::normalize(self : Cryptohashsha3Series) -> Cryptohashsha3Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashsha3Series::cumsum(self : Cryptohashsha3Series) -> Cryptohashsha3Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashsha3Series::to_string(self : Cryptohashsha3Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha3Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha3_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha3Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha3_matrix_identity(n : Int) -> Cryptohashsha3Matrix {
  let m = crypto_hash_sha3_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashsha3Matrix::get(self : Cryptohashsha3Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashsha3Matrix::transpose(self : Cryptohashsha3Matrix) -> Cryptohashsha3Matrix {
  let result = crypto_hash_sha3_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashsha3Matrix::add(self : Cryptohashsha3Matrix, other : Cryptohashsha3Matrix) -> Cryptohashsha3Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_sha3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashsha3Matrix::scale(self : Cryptohashsha3Matrix, s : Double) -> Cryptohashsha3Matrix {
  let result = crypto_hash_sha3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashsha3Matrix::multiply(self : Cryptohashsha3Matrix, other : Cryptohashsha3Matrix) -> Cryptohashsha3Matrix {
  if self.cols != other.rows { return crypto_hash_sha3_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_sha3_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Cryptohashsha3Matrix::trace(self : Cryptohashsha3Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashsha3Matrix::det(self : Cryptohashsha3Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashsha3Matrix::norm(self : Cryptohashsha3Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashsha3Matrix::to_string(self : Cryptohashsha3Matrix) -> String {
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

pub(all) struct Cryptohashsha3Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha3_make_vector(comps : Array[Double]) -> Cryptohashsha3Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha3_vector_zero(dim : Int) -> Cryptohashsha3Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashsha3Vector::add(self : Cryptohashsha3Vector, other : Cryptohashsha3Vector) -> Cryptohashsha3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha3Vector::sub(self : Cryptohashsha3Vector, other : Cryptohashsha3Vector) -> Cryptohashsha3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha3Vector::scale(self : Cryptohashsha3Vector, s : Double) -> Cryptohashsha3Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashsha3Vector::dot(self : Cryptohashsha3Vector, other : Cryptohashsha3Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashsha3Vector::norm(self : Cryptohashsha3Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashsha3Vector::normalize(self : Cryptohashsha3Vector) -> Cryptohashsha3Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha3Vector::dist(self : Cryptohashsha3Vector, other : Cryptohashsha3Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashsha3Vector::to_string(self : Cryptohashsha3Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha3Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_frame_make(size : Int) -> Cryptohashsha3Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Frame::len(self : Cryptohashsha3Frame) -> Int { self.size }

pub fn Cryptohashsha3Frame::get(self : Cryptohashsha3Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Frame::set(self : Cryptohashsha3Frame, i : Int, v : Double) -> Cryptohashsha3Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Frame::sum(self : Cryptohashsha3Frame) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Frame::mean(self : Cryptohashsha3Frame) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Frame::scale(self : Cryptohashsha3Frame, f : Double) -> Cryptohashsha3Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Frame::add(self : Cryptohashsha3Frame, other : Cryptohashsha3Frame) -> Cryptohashsha3Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Frame::copy(self : Cryptohashsha3Frame) -> Cryptohashsha3Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Frame::fill(self : Cryptohashsha3Frame, v : Double) -> Cryptohashsha3Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Frame::min(self : Cryptohashsha3Frame) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Frame::max(self : Cryptohashsha3Frame) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Frame::to_string(self : Cryptohashsha3Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_table_make(size : Int) -> Cryptohashsha3Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Table::len(self : Cryptohashsha3Table) -> Int { self.size }

pub fn Cryptohashsha3Table::get(self : Cryptohashsha3Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Table::set(self : Cryptohashsha3Table, i : Int, v : Double) -> Cryptohashsha3Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Table::sum(self : Cryptohashsha3Table) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Table::mean(self : Cryptohashsha3Table) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Table::scale(self : Cryptohashsha3Table, f : Double) -> Cryptohashsha3Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Table::add(self : Cryptohashsha3Table, other : Cryptohashsha3Table) -> Cryptohashsha3Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Table::copy(self : Cryptohashsha3Table) -> Cryptohashsha3Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Table::fill(self : Cryptohashsha3Table, v : Double) -> Cryptohashsha3Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Table::min(self : Cryptohashsha3Table) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Table::max(self : Cryptohashsha3Table) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Table::to_string(self : Cryptohashsha3Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_graphn_make(size : Int) -> Cryptohashsha3GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3GraphN::len(self : Cryptohashsha3GraphN) -> Int { self.size }

pub fn Cryptohashsha3GraphN::get(self : Cryptohashsha3GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3GraphN::set(self : Cryptohashsha3GraphN, i : Int, v : Double) -> Cryptohashsha3GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3GraphN::sum(self : Cryptohashsha3GraphN) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3GraphN::mean(self : Cryptohashsha3GraphN) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3GraphN::scale(self : Cryptohashsha3GraphN, f : Double) -> Cryptohashsha3GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3GraphN::add(self : Cryptohashsha3GraphN, other : Cryptohashsha3GraphN) -> Cryptohashsha3GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3GraphN::copy(self : Cryptohashsha3GraphN) -> Cryptohashsha3GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3GraphN::fill(self : Cryptohashsha3GraphN, v : Double) -> Cryptohashsha3GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3GraphN::min(self : Cryptohashsha3GraphN) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3GraphN::max(self : Cryptohashsha3GraphN) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3GraphN::to_string(self : Cryptohashsha3GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_node_make(size : Int) -> Cryptohashsha3Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Node::len(self : Cryptohashsha3Node) -> Int { self.size }

pub fn Cryptohashsha3Node::get(self : Cryptohashsha3Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Node::set(self : Cryptohashsha3Node, i : Int, v : Double) -> Cryptohashsha3Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Node::sum(self : Cryptohashsha3Node) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Node::mean(self : Cryptohashsha3Node) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Node::scale(self : Cryptohashsha3Node, f : Double) -> Cryptohashsha3Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Node::add(self : Cryptohashsha3Node, other : Cryptohashsha3Node) -> Cryptohashsha3Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Node::copy(self : Cryptohashsha3Node) -> Cryptohashsha3Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Node::fill(self : Cryptohashsha3Node, v : Double) -> Cryptohashsha3Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Node::min(self : Cryptohashsha3Node) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Node::max(self : Cryptohashsha3Node) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Node::to_string(self : Cryptohashsha3Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_edge_make(size : Int) -> Cryptohashsha3Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Edge::len(self : Cryptohashsha3Edge) -> Int { self.size }

pub fn Cryptohashsha3Edge::get(self : Cryptohashsha3Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Edge::set(self : Cryptohashsha3Edge, i : Int, v : Double) -> Cryptohashsha3Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Edge::sum(self : Cryptohashsha3Edge) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Edge::mean(self : Cryptohashsha3Edge) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Edge::scale(self : Cryptohashsha3Edge, f : Double) -> Cryptohashsha3Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Edge::add(self : Cryptohashsha3Edge, other : Cryptohashsha3Edge) -> Cryptohashsha3Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Edge::copy(self : Cryptohashsha3Edge) -> Cryptohashsha3Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Edge::fill(self : Cryptohashsha3Edge, v : Double) -> Cryptohashsha3Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Edge::min(self : Cryptohashsha3Edge) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Edge::max(self : Cryptohashsha3Edge) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Edge::to_string(self : Cryptohashsha3Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_path_make(size : Int) -> Cryptohashsha3Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Path::len(self : Cryptohashsha3Path) -> Int { self.size }

pub fn Cryptohashsha3Path::get(self : Cryptohashsha3Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Path::set(self : Cryptohashsha3Path, i : Int, v : Double) -> Cryptohashsha3Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Path::sum(self : Cryptohashsha3Path) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Path::mean(self : Cryptohashsha3Path) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Path::scale(self : Cryptohashsha3Path, f : Double) -> Cryptohashsha3Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Path::add(self : Cryptohashsha3Path, other : Cryptohashsha3Path) -> Cryptohashsha3Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Path::copy(self : Cryptohashsha3Path) -> Cryptohashsha3Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Path::fill(self : Cryptohashsha3Path, v : Double) -> Cryptohashsha3Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Path::min(self : Cryptohashsha3Path) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Path::max(self : Cryptohashsha3Path) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Path::to_string(self : Cryptohashsha3Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_cluster_make(size : Int) -> Cryptohashsha3Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Cluster::len(self : Cryptohashsha3Cluster) -> Int { self.size }

pub fn Cryptohashsha3Cluster::get(self : Cryptohashsha3Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Cluster::set(self : Cryptohashsha3Cluster, i : Int, v : Double) -> Cryptohashsha3Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Cluster::sum(self : Cryptohashsha3Cluster) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Cluster::mean(self : Cryptohashsha3Cluster) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Cluster::scale(self : Cryptohashsha3Cluster, f : Double) -> Cryptohashsha3Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Cluster::add(self : Cryptohashsha3Cluster, other : Cryptohashsha3Cluster) -> Cryptohashsha3Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Cluster::copy(self : Cryptohashsha3Cluster) -> Cryptohashsha3Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Cluster::fill(self : Cryptohashsha3Cluster, v : Double) -> Cryptohashsha3Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Cluster::min(self : Cryptohashsha3Cluster) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Cluster::max(self : Cryptohashsha3Cluster) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Cluster::to_string(self : Cryptohashsha3Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_model_make(size : Int) -> Cryptohashsha3Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Model::len(self : Cryptohashsha3Model) -> Int { self.size }

pub fn Cryptohashsha3Model::get(self : Cryptohashsha3Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Model::set(self : Cryptohashsha3Model, i : Int, v : Double) -> Cryptohashsha3Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Model::sum(self : Cryptohashsha3Model) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Model::mean(self : Cryptohashsha3Model) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Model::scale(self : Cryptohashsha3Model, f : Double) -> Cryptohashsha3Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Model::add(self : Cryptohashsha3Model, other : Cryptohashsha3Model) -> Cryptohashsha3Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Model::copy(self : Cryptohashsha3Model) -> Cryptohashsha3Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Model::fill(self : Cryptohashsha3Model, v : Double) -> Cryptohashsha3Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Model::min(self : Cryptohashsha3Model) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Model::max(self : Cryptohashsha3Model) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Model::to_string(self : Cryptohashsha3Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_layer_make(size : Int) -> Cryptohashsha3Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Layer::len(self : Cryptohashsha3Layer) -> Int { self.size }

pub fn Cryptohashsha3Layer::get(self : Cryptohashsha3Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Layer::set(self : Cryptohashsha3Layer, i : Int, v : Double) -> Cryptohashsha3Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Layer::sum(self : Cryptohashsha3Layer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Layer::mean(self : Cryptohashsha3Layer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Layer::scale(self : Cryptohashsha3Layer, f : Double) -> Cryptohashsha3Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Layer::add(self : Cryptohashsha3Layer, other : Cryptohashsha3Layer) -> Cryptohashsha3Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Layer::copy(self : Cryptohashsha3Layer) -> Cryptohashsha3Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Layer::fill(self : Cryptohashsha3Layer, v : Double) -> Cryptohashsha3Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Layer::min(self : Cryptohashsha3Layer) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Layer::max(self : Cryptohashsha3Layer) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Layer::to_string(self : Cryptohashsha3Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_buffer_make(size : Int) -> Cryptohashsha3Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Buffer::len(self : Cryptohashsha3Buffer) -> Int { self.size }

pub fn Cryptohashsha3Buffer::get(self : Cryptohashsha3Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Buffer::set(self : Cryptohashsha3Buffer, i : Int, v : Double) -> Cryptohashsha3Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Buffer::sum(self : Cryptohashsha3Buffer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Buffer::mean(self : Cryptohashsha3Buffer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Buffer::scale(self : Cryptohashsha3Buffer, f : Double) -> Cryptohashsha3Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Buffer::add(self : Cryptohashsha3Buffer, other : Cryptohashsha3Buffer) -> Cryptohashsha3Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Buffer::copy(self : Cryptohashsha3Buffer) -> Cryptohashsha3Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Buffer::fill(self : Cryptohashsha3Buffer, v : Double) -> Cryptohashsha3Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Buffer::min(self : Cryptohashsha3Buffer) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Buffer::max(self : Cryptohashsha3Buffer) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Buffer::to_string(self : Cryptohashsha3Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_cursor_make(size : Int) -> Cryptohashsha3Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Cursor::len(self : Cryptohashsha3Cursor) -> Int { self.size }

pub fn Cryptohashsha3Cursor::get(self : Cryptohashsha3Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Cursor::set(self : Cryptohashsha3Cursor, i : Int, v : Double) -> Cryptohashsha3Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Cursor::sum(self : Cryptohashsha3Cursor) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Cursor::mean(self : Cryptohashsha3Cursor) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Cursor::scale(self : Cryptohashsha3Cursor, f : Double) -> Cryptohashsha3Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Cursor::add(self : Cryptohashsha3Cursor, other : Cryptohashsha3Cursor) -> Cryptohashsha3Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Cursor::copy(self : Cryptohashsha3Cursor) -> Cryptohashsha3Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Cursor::fill(self : Cryptohashsha3Cursor, v : Double) -> Cryptohashsha3Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Cursor::min(self : Cryptohashsha3Cursor) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Cursor::max(self : Cryptohashsha3Cursor) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Cursor::to_string(self : Cryptohashsha3Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_view_make(size : Int) -> Cryptohashsha3View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3View::len(self : Cryptohashsha3View) -> Int { self.size }

pub fn Cryptohashsha3View::get(self : Cryptohashsha3View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3View::set(self : Cryptohashsha3View, i : Int, v : Double) -> Cryptohashsha3View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3View::sum(self : Cryptohashsha3View) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3View::mean(self : Cryptohashsha3View) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3View::scale(self : Cryptohashsha3View, f : Double) -> Cryptohashsha3View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3View::add(self : Cryptohashsha3View, other : Cryptohashsha3View) -> Cryptohashsha3View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3View::copy(self : Cryptohashsha3View) -> Cryptohashsha3View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3View::fill(self : Cryptohashsha3View, v : Double) -> Cryptohashsha3View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3View::min(self : Cryptohashsha3View) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3View::max(self : Cryptohashsha3View) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3View::to_string(self : Cryptohashsha3View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_range_make(size : Int) -> Cryptohashsha3Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Range::len(self : Cryptohashsha3Range) -> Int { self.size }

pub fn Cryptohashsha3Range::get(self : Cryptohashsha3Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Range::set(self : Cryptohashsha3Range, i : Int, v : Double) -> Cryptohashsha3Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Range::sum(self : Cryptohashsha3Range) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Range::mean(self : Cryptohashsha3Range) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Range::scale(self : Cryptohashsha3Range, f : Double) -> Cryptohashsha3Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Range::add(self : Cryptohashsha3Range, other : Cryptohashsha3Range) -> Cryptohashsha3Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Range::copy(self : Cryptohashsha3Range) -> Cryptohashsha3Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Range::fill(self : Cryptohashsha3Range, v : Double) -> Cryptohashsha3Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Range::min(self : Cryptohashsha3Range) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Range::max(self : Cryptohashsha3Range) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Range::to_string(self : Cryptohashsha3Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_slice_make(size : Int) -> Cryptohashsha3Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha3Slice::len(self : Cryptohashsha3Slice) -> Int { self.size }

pub fn Cryptohashsha3Slice::get(self : Cryptohashsha3Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha3Slice::set(self : Cryptohashsha3Slice, i : Int, v : Double) -> Cryptohashsha3Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Slice::sum(self : Cryptohashsha3Slice) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha3Slice::mean(self : Cryptohashsha3Slice) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha3Slice::scale(self : Cryptohashsha3Slice, f : Double) -> Cryptohashsha3Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Slice::add(self : Cryptohashsha3Slice, other : Cryptohashsha3Slice) -> Cryptohashsha3Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha3Slice::copy(self : Cryptohashsha3Slice) -> Cryptohashsha3Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Slice::fill(self : Cryptohashsha3Slice, v : Double) -> Cryptohashsha3Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha3Slice::min(self : Cryptohashsha3Slice) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha3Slice::max(self : Cryptohashsha3Slice) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha3Slice::to_string(self : Cryptohashsha3Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

