///===
/// extcore/crypto_hash_sha1

pub(all) struct Cryptohashsha1Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha1_make_point(x : Double, y : Double) -> Cryptohashsha1Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha1_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha1Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashsha1Point::x(self : Cryptohashsha1Point) -> Double { self.x }

pub fn Cryptohashsha1Point::y(self : Cryptohashsha1Point) -> Double { self.y }

pub fn Cryptohashsha1Point::z(self : Cryptohashsha1Point) -> Double { self.z }

pub fn Cryptohashsha1Point::label(self : Cryptohashsha1Point) -> Int { self.label }

pub fn Cryptohashsha1Point::dist(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashsha1Point::add(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashsha1Point::sub(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashsha1Point::scale(self : Cryptohashsha1Point, s : Double) -> Cryptohashsha1Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashsha1Point::dot(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashsha1Point::cross(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashsha1Point::norm(self : Cryptohashsha1Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashsha1Point::normalize(self : Cryptohashsha1Point) -> Cryptohashsha1Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha1Point::negate(self : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashsha1Point::mid(self : Cryptohashsha1Point, other : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashsha1Point::lerp(self : Cryptohashsha1Point, other : Cryptohashsha1Point, t : Double) -> Cryptohashsha1Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashsha1Point::to_string(self : Cryptohashsha1Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashsha1Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha1_make_series(vals : Array[Double], name : String) -> Cryptohashsha1Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashsha1Series::len(self : Cryptohashsha1Series) -> Int { self.vals.length() }

pub fn Cryptohashsha1Series::sum(self : Cryptohashsha1Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashsha1Series::mean(self : Cryptohashsha1Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashsha1Series::min(self : Cryptohashsha1Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashsha1Series::max(self : Cryptohashsha1Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashsha1Series::range(self : Cryptohashsha1Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashsha1Series::variance(self : Cryptohashsha1Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashsha1Series::std(self : Cryptohashsha1Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashsha1Series::median(self : Cryptohashsha1Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashsha1Series::scale(self : Cryptohashsha1Series, f : Double) -> Cryptohashsha1Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashsha1Series::add(self : Cryptohashsha1Series, other : Cryptohashsha1Series) -> Cryptohashsha1Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashsha1Series::sub(self : Cryptohashsha1Series, other : Cryptohashsha1Series) -> Cryptohashsha1Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashsha1Series::normalize(self : Cryptohashsha1Series) -> Cryptohashsha1Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashsha1Series::cumsum(self : Cryptohashsha1Series) -> Cryptohashsha1Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashsha1Series::to_string(self : Cryptohashsha1Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha1Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha1_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha1Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha1_matrix_identity(n : Int) -> Cryptohashsha1Matrix {
  let m = crypto_hash_sha1_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashsha1Matrix::get(self : Cryptohashsha1Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashsha1Matrix::transpose(self : Cryptohashsha1Matrix) -> Cryptohashsha1Matrix {
  let result = crypto_hash_sha1_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashsha1Matrix::add(self : Cryptohashsha1Matrix, other : Cryptohashsha1Matrix) -> Cryptohashsha1Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_sha1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashsha1Matrix::scale(self : Cryptohashsha1Matrix, s : Double) -> Cryptohashsha1Matrix {
  let result = crypto_hash_sha1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashsha1Matrix::multiply(self : Cryptohashsha1Matrix, other : Cryptohashsha1Matrix) -> Cryptohashsha1Matrix {
  if self.cols != other.rows { return crypto_hash_sha1_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_sha1_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Cryptohashsha1Matrix::trace(self : Cryptohashsha1Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashsha1Matrix::det(self : Cryptohashsha1Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashsha1Matrix::norm(self : Cryptohashsha1Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashsha1Matrix::to_string(self : Cryptohashsha1Matrix) -> String {
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

pub(all) struct Cryptohashsha1Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha1_make_vector(comps : Array[Double]) -> Cryptohashsha1Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha1_vector_zero(dim : Int) -> Cryptohashsha1Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashsha1Vector::add(self : Cryptohashsha1Vector, other : Cryptohashsha1Vector) -> Cryptohashsha1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha1Vector::sub(self : Cryptohashsha1Vector, other : Cryptohashsha1Vector) -> Cryptohashsha1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha1Vector::scale(self : Cryptohashsha1Vector, s : Double) -> Cryptohashsha1Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashsha1Vector::dot(self : Cryptohashsha1Vector, other : Cryptohashsha1Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashsha1Vector::norm(self : Cryptohashsha1Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashsha1Vector::normalize(self : Cryptohashsha1Vector) -> Cryptohashsha1Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha1Vector::dist(self : Cryptohashsha1Vector, other : Cryptohashsha1Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashsha1Vector::to_string(self : Cryptohashsha1Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha1Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_frame_make(size : Int) -> Cryptohashsha1Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Frame::len(self : Cryptohashsha1Frame) -> Int { self.size }

pub fn Cryptohashsha1Frame::get(self : Cryptohashsha1Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Frame::set(self : Cryptohashsha1Frame, i : Int, v : Double) -> Cryptohashsha1Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Frame::sum(self : Cryptohashsha1Frame) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Frame::mean(self : Cryptohashsha1Frame) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Frame::scale(self : Cryptohashsha1Frame, f : Double) -> Cryptohashsha1Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Frame::add(self : Cryptohashsha1Frame, other : Cryptohashsha1Frame) -> Cryptohashsha1Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Frame::copy(self : Cryptohashsha1Frame) -> Cryptohashsha1Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Frame::fill(self : Cryptohashsha1Frame, v : Double) -> Cryptohashsha1Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Frame::min(self : Cryptohashsha1Frame) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Frame::max(self : Cryptohashsha1Frame) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Frame::to_string(self : Cryptohashsha1Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_table_make(size : Int) -> Cryptohashsha1Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Table::len(self : Cryptohashsha1Table) -> Int { self.size }

pub fn Cryptohashsha1Table::get(self : Cryptohashsha1Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Table::set(self : Cryptohashsha1Table, i : Int, v : Double) -> Cryptohashsha1Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Table::sum(self : Cryptohashsha1Table) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Table::mean(self : Cryptohashsha1Table) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Table::scale(self : Cryptohashsha1Table, f : Double) -> Cryptohashsha1Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Table::add(self : Cryptohashsha1Table, other : Cryptohashsha1Table) -> Cryptohashsha1Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Table::copy(self : Cryptohashsha1Table) -> Cryptohashsha1Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Table::fill(self : Cryptohashsha1Table, v : Double) -> Cryptohashsha1Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Table::min(self : Cryptohashsha1Table) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Table::max(self : Cryptohashsha1Table) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Table::to_string(self : Cryptohashsha1Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_graphn_make(size : Int) -> Cryptohashsha1GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1GraphN::len(self : Cryptohashsha1GraphN) -> Int { self.size }

pub fn Cryptohashsha1GraphN::get(self : Cryptohashsha1GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1GraphN::set(self : Cryptohashsha1GraphN, i : Int, v : Double) -> Cryptohashsha1GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1GraphN::sum(self : Cryptohashsha1GraphN) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1GraphN::mean(self : Cryptohashsha1GraphN) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1GraphN::scale(self : Cryptohashsha1GraphN, f : Double) -> Cryptohashsha1GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1GraphN::add(self : Cryptohashsha1GraphN, other : Cryptohashsha1GraphN) -> Cryptohashsha1GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1GraphN::copy(self : Cryptohashsha1GraphN) -> Cryptohashsha1GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1GraphN::fill(self : Cryptohashsha1GraphN, v : Double) -> Cryptohashsha1GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1GraphN::min(self : Cryptohashsha1GraphN) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1GraphN::max(self : Cryptohashsha1GraphN) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1GraphN::to_string(self : Cryptohashsha1GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_node_make(size : Int) -> Cryptohashsha1Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Node::len(self : Cryptohashsha1Node) -> Int { self.size }

pub fn Cryptohashsha1Node::get(self : Cryptohashsha1Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Node::set(self : Cryptohashsha1Node, i : Int, v : Double) -> Cryptohashsha1Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Node::sum(self : Cryptohashsha1Node) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Node::mean(self : Cryptohashsha1Node) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Node::scale(self : Cryptohashsha1Node, f : Double) -> Cryptohashsha1Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Node::add(self : Cryptohashsha1Node, other : Cryptohashsha1Node) -> Cryptohashsha1Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Node::copy(self : Cryptohashsha1Node) -> Cryptohashsha1Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Node::fill(self : Cryptohashsha1Node, v : Double) -> Cryptohashsha1Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Node::min(self : Cryptohashsha1Node) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Node::max(self : Cryptohashsha1Node) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Node::to_string(self : Cryptohashsha1Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_edge_make(size : Int) -> Cryptohashsha1Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Edge::len(self : Cryptohashsha1Edge) -> Int { self.size }

pub fn Cryptohashsha1Edge::get(self : Cryptohashsha1Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Edge::set(self : Cryptohashsha1Edge, i : Int, v : Double) -> Cryptohashsha1Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Edge::sum(self : Cryptohashsha1Edge) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Edge::mean(self : Cryptohashsha1Edge) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Edge::scale(self : Cryptohashsha1Edge, f : Double) -> Cryptohashsha1Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Edge::add(self : Cryptohashsha1Edge, other : Cryptohashsha1Edge) -> Cryptohashsha1Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Edge::copy(self : Cryptohashsha1Edge) -> Cryptohashsha1Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Edge::fill(self : Cryptohashsha1Edge, v : Double) -> Cryptohashsha1Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Edge::min(self : Cryptohashsha1Edge) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Edge::max(self : Cryptohashsha1Edge) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Edge::to_string(self : Cryptohashsha1Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_path_make(size : Int) -> Cryptohashsha1Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Path::len(self : Cryptohashsha1Path) -> Int { self.size }

pub fn Cryptohashsha1Path::get(self : Cryptohashsha1Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Path::set(self : Cryptohashsha1Path, i : Int, v : Double) -> Cryptohashsha1Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Path::sum(self : Cryptohashsha1Path) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Path::mean(self : Cryptohashsha1Path) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Path::scale(self : Cryptohashsha1Path, f : Double) -> Cryptohashsha1Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Path::add(self : Cryptohashsha1Path, other : Cryptohashsha1Path) -> Cryptohashsha1Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Path::copy(self : Cryptohashsha1Path) -> Cryptohashsha1Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Path::fill(self : Cryptohashsha1Path, v : Double) -> Cryptohashsha1Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Path::min(self : Cryptohashsha1Path) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Path::max(self : Cryptohashsha1Path) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Path::to_string(self : Cryptohashsha1Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_cluster_make(size : Int) -> Cryptohashsha1Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Cluster::len(self : Cryptohashsha1Cluster) -> Int { self.size }

pub fn Cryptohashsha1Cluster::get(self : Cryptohashsha1Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Cluster::set(self : Cryptohashsha1Cluster, i : Int, v : Double) -> Cryptohashsha1Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Cluster::sum(self : Cryptohashsha1Cluster) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Cluster::mean(self : Cryptohashsha1Cluster) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Cluster::scale(self : Cryptohashsha1Cluster, f : Double) -> Cryptohashsha1Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Cluster::add(self : Cryptohashsha1Cluster, other : Cryptohashsha1Cluster) -> Cryptohashsha1Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Cluster::copy(self : Cryptohashsha1Cluster) -> Cryptohashsha1Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Cluster::fill(self : Cryptohashsha1Cluster, v : Double) -> Cryptohashsha1Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Cluster::min(self : Cryptohashsha1Cluster) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Cluster::max(self : Cryptohashsha1Cluster) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Cluster::to_string(self : Cryptohashsha1Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_model_make(size : Int) -> Cryptohashsha1Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Model::len(self : Cryptohashsha1Model) -> Int { self.size }

pub fn Cryptohashsha1Model::get(self : Cryptohashsha1Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Model::set(self : Cryptohashsha1Model, i : Int, v : Double) -> Cryptohashsha1Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Model::sum(self : Cryptohashsha1Model) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Model::mean(self : Cryptohashsha1Model) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Model::scale(self : Cryptohashsha1Model, f : Double) -> Cryptohashsha1Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Model::add(self : Cryptohashsha1Model, other : Cryptohashsha1Model) -> Cryptohashsha1Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Model::copy(self : Cryptohashsha1Model) -> Cryptohashsha1Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Model::fill(self : Cryptohashsha1Model, v : Double) -> Cryptohashsha1Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Model::min(self : Cryptohashsha1Model) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Model::max(self : Cryptohashsha1Model) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Model::to_string(self : Cryptohashsha1Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_layer_make(size : Int) -> Cryptohashsha1Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Layer::len(self : Cryptohashsha1Layer) -> Int { self.size }

pub fn Cryptohashsha1Layer::get(self : Cryptohashsha1Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Layer::set(self : Cryptohashsha1Layer, i : Int, v : Double) -> Cryptohashsha1Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Layer::sum(self : Cryptohashsha1Layer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Layer::mean(self : Cryptohashsha1Layer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Layer::scale(self : Cryptohashsha1Layer, f : Double) -> Cryptohashsha1Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Layer::add(self : Cryptohashsha1Layer, other : Cryptohashsha1Layer) -> Cryptohashsha1Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Layer::copy(self : Cryptohashsha1Layer) -> Cryptohashsha1Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Layer::fill(self : Cryptohashsha1Layer, v : Double) -> Cryptohashsha1Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Layer::min(self : Cryptohashsha1Layer) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Layer::max(self : Cryptohashsha1Layer) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Layer::to_string(self : Cryptohashsha1Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_buffer_make(size : Int) -> Cryptohashsha1Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Buffer::len(self : Cryptohashsha1Buffer) -> Int { self.size }

pub fn Cryptohashsha1Buffer::get(self : Cryptohashsha1Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Buffer::set(self : Cryptohashsha1Buffer, i : Int, v : Double) -> Cryptohashsha1Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Buffer::sum(self : Cryptohashsha1Buffer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Buffer::mean(self : Cryptohashsha1Buffer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Buffer::scale(self : Cryptohashsha1Buffer, f : Double) -> Cryptohashsha1Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Buffer::add(self : Cryptohashsha1Buffer, other : Cryptohashsha1Buffer) -> Cryptohashsha1Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Buffer::copy(self : Cryptohashsha1Buffer) -> Cryptohashsha1Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Buffer::fill(self : Cryptohashsha1Buffer, v : Double) -> Cryptohashsha1Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Buffer::min(self : Cryptohashsha1Buffer) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Buffer::max(self : Cryptohashsha1Buffer) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Buffer::to_string(self : Cryptohashsha1Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_cursor_make(size : Int) -> Cryptohashsha1Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Cursor::len(self : Cryptohashsha1Cursor) -> Int { self.size }

pub fn Cryptohashsha1Cursor::get(self : Cryptohashsha1Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Cursor::set(self : Cryptohashsha1Cursor, i : Int, v : Double) -> Cryptohashsha1Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Cursor::sum(self : Cryptohashsha1Cursor) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Cursor::mean(self : Cryptohashsha1Cursor) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Cursor::scale(self : Cryptohashsha1Cursor, f : Double) -> Cryptohashsha1Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Cursor::add(self : Cryptohashsha1Cursor, other : Cryptohashsha1Cursor) -> Cryptohashsha1Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Cursor::copy(self : Cryptohashsha1Cursor) -> Cryptohashsha1Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Cursor::fill(self : Cryptohashsha1Cursor, v : Double) -> Cryptohashsha1Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Cursor::min(self : Cryptohashsha1Cursor) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Cursor::max(self : Cryptohashsha1Cursor) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Cursor::to_string(self : Cryptohashsha1Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_view_make(size : Int) -> Cryptohashsha1View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1View::len(self : Cryptohashsha1View) -> Int { self.size }

pub fn Cryptohashsha1View::get(self : Cryptohashsha1View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1View::set(self : Cryptohashsha1View, i : Int, v : Double) -> Cryptohashsha1View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1View::sum(self : Cryptohashsha1View) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1View::mean(self : Cryptohashsha1View) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1View::scale(self : Cryptohashsha1View, f : Double) -> Cryptohashsha1View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1View::add(self : Cryptohashsha1View, other : Cryptohashsha1View) -> Cryptohashsha1View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1View::copy(self : Cryptohashsha1View) -> Cryptohashsha1View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1View::fill(self : Cryptohashsha1View, v : Double) -> Cryptohashsha1View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1View::min(self : Cryptohashsha1View) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1View::max(self : Cryptohashsha1View) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1View::to_string(self : Cryptohashsha1View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_range_make(size : Int) -> Cryptohashsha1Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Range::len(self : Cryptohashsha1Range) -> Int { self.size }

pub fn Cryptohashsha1Range::get(self : Cryptohashsha1Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Range::set(self : Cryptohashsha1Range, i : Int, v : Double) -> Cryptohashsha1Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Range::sum(self : Cryptohashsha1Range) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Range::mean(self : Cryptohashsha1Range) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Range::scale(self : Cryptohashsha1Range, f : Double) -> Cryptohashsha1Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Range::add(self : Cryptohashsha1Range, other : Cryptohashsha1Range) -> Cryptohashsha1Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Range::copy(self : Cryptohashsha1Range) -> Cryptohashsha1Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Range::fill(self : Cryptohashsha1Range, v : Double) -> Cryptohashsha1Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Range::min(self : Cryptohashsha1Range) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Range::max(self : Cryptohashsha1Range) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Range::to_string(self : Cryptohashsha1Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_slice_make(size : Int) -> Cryptohashsha1Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha1Slice::len(self : Cryptohashsha1Slice) -> Int { self.size }

pub fn Cryptohashsha1Slice::get(self : Cryptohashsha1Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha1Slice::set(self : Cryptohashsha1Slice, i : Int, v : Double) -> Cryptohashsha1Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Slice::sum(self : Cryptohashsha1Slice) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha1Slice::mean(self : Cryptohashsha1Slice) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha1Slice::scale(self : Cryptohashsha1Slice, f : Double) -> Cryptohashsha1Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Slice::add(self : Cryptohashsha1Slice, other : Cryptohashsha1Slice) -> Cryptohashsha1Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha1Slice::copy(self : Cryptohashsha1Slice) -> Cryptohashsha1Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Slice::fill(self : Cryptohashsha1Slice, v : Double) -> Cryptohashsha1Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha1Slice::min(self : Cryptohashsha1Slice) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha1Slice::max(self : Cryptohashsha1Slice) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha1Slice::to_string(self : Cryptohashsha1Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

