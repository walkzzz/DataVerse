///===
/// extcore/crypto_hash_sha512

pub(all) struct Cryptohashsha512Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha512_make_point(x : Double, y : Double) -> Cryptohashsha512Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha512_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha512Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashsha512Point::x(self : Cryptohashsha512Point) -> Double { self.x }

pub fn Cryptohashsha512Point::y(self : Cryptohashsha512Point) -> Double { self.y }

pub fn Cryptohashsha512Point::z(self : Cryptohashsha512Point) -> Double { self.z }

pub fn Cryptohashsha512Point::label(self : Cryptohashsha512Point) -> Int { self.label }

pub fn Cryptohashsha512Point::dist(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashsha512Point::add(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashsha512Point::sub(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashsha512Point::scale(self : Cryptohashsha512Point, s : Double) -> Cryptohashsha512Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashsha512Point::dot(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashsha512Point::cross(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashsha512Point::norm(self : Cryptohashsha512Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashsha512Point::normalize(self : Cryptohashsha512Point) -> Cryptohashsha512Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha512Point::negate(self : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashsha512Point::mid(self : Cryptohashsha512Point, other : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashsha512Point::lerp(self : Cryptohashsha512Point, other : Cryptohashsha512Point, t : Double) -> Cryptohashsha512Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashsha512Point::to_string(self : Cryptohashsha512Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashsha512Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha512_make_series(vals : Array[Double], name : String) -> Cryptohashsha512Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashsha512Series::len(self : Cryptohashsha512Series) -> Int { self.vals.length() }

pub fn Cryptohashsha512Series::sum(self : Cryptohashsha512Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashsha512Series::mean(self : Cryptohashsha512Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashsha512Series::min(self : Cryptohashsha512Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashsha512Series::max(self : Cryptohashsha512Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashsha512Series::range(self : Cryptohashsha512Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashsha512Series::variance(self : Cryptohashsha512Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashsha512Series::std(self : Cryptohashsha512Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashsha512Series::median(self : Cryptohashsha512Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashsha512Series::scale(self : Cryptohashsha512Series, f : Double) -> Cryptohashsha512Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashsha512Series::add(self : Cryptohashsha512Series, other : Cryptohashsha512Series) -> Cryptohashsha512Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashsha512Series::sub(self : Cryptohashsha512Series, other : Cryptohashsha512Series) -> Cryptohashsha512Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashsha512Series::normalize(self : Cryptohashsha512Series) -> Cryptohashsha512Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashsha512Series::cumsum(self : Cryptohashsha512Series) -> Cryptohashsha512Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashsha512Series::to_string(self : Cryptohashsha512Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha512Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha512_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha512Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha512_matrix_identity(n : Int) -> Cryptohashsha512Matrix {
  let m = crypto_hash_sha512_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashsha512Matrix::get(self : Cryptohashsha512Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashsha512Matrix::transpose(self : Cryptohashsha512Matrix) -> Cryptohashsha512Matrix {
  let result = crypto_hash_sha512_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashsha512Matrix::add(self : Cryptohashsha512Matrix, other : Cryptohashsha512Matrix) -> Cryptohashsha512Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_sha512_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashsha512Matrix::scale(self : Cryptohashsha512Matrix, s : Double) -> Cryptohashsha512Matrix {
  let result = crypto_hash_sha512_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashsha512Matrix::multiply(self : Cryptohashsha512Matrix, other : Cryptohashsha512Matrix) -> Cryptohashsha512Matrix {
  if self.cols != other.rows { return crypto_hash_sha512_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_sha512_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Cryptohashsha512Matrix::trace(self : Cryptohashsha512Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashsha512Matrix::det(self : Cryptohashsha512Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashsha512Matrix::norm(self : Cryptohashsha512Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashsha512Matrix::to_string(self : Cryptohashsha512Matrix) -> String {
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

pub(all) struct Cryptohashsha512Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha512_make_vector(comps : Array[Double]) -> Cryptohashsha512Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha512_vector_zero(dim : Int) -> Cryptohashsha512Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashsha512Vector::add(self : Cryptohashsha512Vector, other : Cryptohashsha512Vector) -> Cryptohashsha512Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha512Vector::sub(self : Cryptohashsha512Vector, other : Cryptohashsha512Vector) -> Cryptohashsha512Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha512Vector::scale(self : Cryptohashsha512Vector, s : Double) -> Cryptohashsha512Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashsha512Vector::dot(self : Cryptohashsha512Vector, other : Cryptohashsha512Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashsha512Vector::norm(self : Cryptohashsha512Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashsha512Vector::normalize(self : Cryptohashsha512Vector) -> Cryptohashsha512Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha512Vector::dist(self : Cryptohashsha512Vector, other : Cryptohashsha512Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashsha512Vector::to_string(self : Cryptohashsha512Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha512Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_frame_make(size : Int) -> Cryptohashsha512Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Frame::len(self : Cryptohashsha512Frame) -> Int { self.size }

pub fn Cryptohashsha512Frame::get(self : Cryptohashsha512Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Frame::set(self : Cryptohashsha512Frame, i : Int, v : Double) -> Cryptohashsha512Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Frame::sum(self : Cryptohashsha512Frame) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Frame::mean(self : Cryptohashsha512Frame) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Frame::scale(self : Cryptohashsha512Frame, f : Double) -> Cryptohashsha512Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Frame::add(self : Cryptohashsha512Frame, other : Cryptohashsha512Frame) -> Cryptohashsha512Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Frame::copy(self : Cryptohashsha512Frame) -> Cryptohashsha512Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Frame::fill(self : Cryptohashsha512Frame, v : Double) -> Cryptohashsha512Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Frame::min(self : Cryptohashsha512Frame) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Frame::max(self : Cryptohashsha512Frame) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Frame::to_string(self : Cryptohashsha512Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_table_make(size : Int) -> Cryptohashsha512Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Table::len(self : Cryptohashsha512Table) -> Int { self.size }

pub fn Cryptohashsha512Table::get(self : Cryptohashsha512Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Table::set(self : Cryptohashsha512Table, i : Int, v : Double) -> Cryptohashsha512Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Table::sum(self : Cryptohashsha512Table) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Table::mean(self : Cryptohashsha512Table) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Table::scale(self : Cryptohashsha512Table, f : Double) -> Cryptohashsha512Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Table::add(self : Cryptohashsha512Table, other : Cryptohashsha512Table) -> Cryptohashsha512Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Table::copy(self : Cryptohashsha512Table) -> Cryptohashsha512Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Table::fill(self : Cryptohashsha512Table, v : Double) -> Cryptohashsha512Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Table::min(self : Cryptohashsha512Table) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Table::max(self : Cryptohashsha512Table) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Table::to_string(self : Cryptohashsha512Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_graphn_make(size : Int) -> Cryptohashsha512GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512GraphN::len(self : Cryptohashsha512GraphN) -> Int { self.size }

pub fn Cryptohashsha512GraphN::get(self : Cryptohashsha512GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512GraphN::set(self : Cryptohashsha512GraphN, i : Int, v : Double) -> Cryptohashsha512GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512GraphN::sum(self : Cryptohashsha512GraphN) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512GraphN::mean(self : Cryptohashsha512GraphN) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512GraphN::scale(self : Cryptohashsha512GraphN, f : Double) -> Cryptohashsha512GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512GraphN::add(self : Cryptohashsha512GraphN, other : Cryptohashsha512GraphN) -> Cryptohashsha512GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512GraphN::copy(self : Cryptohashsha512GraphN) -> Cryptohashsha512GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512GraphN::fill(self : Cryptohashsha512GraphN, v : Double) -> Cryptohashsha512GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512GraphN::min(self : Cryptohashsha512GraphN) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512GraphN::max(self : Cryptohashsha512GraphN) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512GraphN::to_string(self : Cryptohashsha512GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_node_make(size : Int) -> Cryptohashsha512Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Node::len(self : Cryptohashsha512Node) -> Int { self.size }

pub fn Cryptohashsha512Node::get(self : Cryptohashsha512Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Node::set(self : Cryptohashsha512Node, i : Int, v : Double) -> Cryptohashsha512Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Node::sum(self : Cryptohashsha512Node) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Node::mean(self : Cryptohashsha512Node) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Node::scale(self : Cryptohashsha512Node, f : Double) -> Cryptohashsha512Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Node::add(self : Cryptohashsha512Node, other : Cryptohashsha512Node) -> Cryptohashsha512Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Node::copy(self : Cryptohashsha512Node) -> Cryptohashsha512Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Node::fill(self : Cryptohashsha512Node, v : Double) -> Cryptohashsha512Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Node::min(self : Cryptohashsha512Node) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Node::max(self : Cryptohashsha512Node) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Node::to_string(self : Cryptohashsha512Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_edge_make(size : Int) -> Cryptohashsha512Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Edge::len(self : Cryptohashsha512Edge) -> Int { self.size }

pub fn Cryptohashsha512Edge::get(self : Cryptohashsha512Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Edge::set(self : Cryptohashsha512Edge, i : Int, v : Double) -> Cryptohashsha512Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Edge::sum(self : Cryptohashsha512Edge) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Edge::mean(self : Cryptohashsha512Edge) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Edge::scale(self : Cryptohashsha512Edge, f : Double) -> Cryptohashsha512Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Edge::add(self : Cryptohashsha512Edge, other : Cryptohashsha512Edge) -> Cryptohashsha512Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Edge::copy(self : Cryptohashsha512Edge) -> Cryptohashsha512Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Edge::fill(self : Cryptohashsha512Edge, v : Double) -> Cryptohashsha512Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Edge::min(self : Cryptohashsha512Edge) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Edge::max(self : Cryptohashsha512Edge) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Edge::to_string(self : Cryptohashsha512Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_path_make(size : Int) -> Cryptohashsha512Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Path::len(self : Cryptohashsha512Path) -> Int { self.size }

pub fn Cryptohashsha512Path::get(self : Cryptohashsha512Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Path::set(self : Cryptohashsha512Path, i : Int, v : Double) -> Cryptohashsha512Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Path::sum(self : Cryptohashsha512Path) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Path::mean(self : Cryptohashsha512Path) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Path::scale(self : Cryptohashsha512Path, f : Double) -> Cryptohashsha512Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Path::add(self : Cryptohashsha512Path, other : Cryptohashsha512Path) -> Cryptohashsha512Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Path::copy(self : Cryptohashsha512Path) -> Cryptohashsha512Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Path::fill(self : Cryptohashsha512Path, v : Double) -> Cryptohashsha512Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Path::min(self : Cryptohashsha512Path) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Path::max(self : Cryptohashsha512Path) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Path::to_string(self : Cryptohashsha512Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_cluster_make(size : Int) -> Cryptohashsha512Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Cluster::len(self : Cryptohashsha512Cluster) -> Int { self.size }

pub fn Cryptohashsha512Cluster::get(self : Cryptohashsha512Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Cluster::set(self : Cryptohashsha512Cluster, i : Int, v : Double) -> Cryptohashsha512Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Cluster::sum(self : Cryptohashsha512Cluster) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Cluster::mean(self : Cryptohashsha512Cluster) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Cluster::scale(self : Cryptohashsha512Cluster, f : Double) -> Cryptohashsha512Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Cluster::add(self : Cryptohashsha512Cluster, other : Cryptohashsha512Cluster) -> Cryptohashsha512Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Cluster::copy(self : Cryptohashsha512Cluster) -> Cryptohashsha512Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Cluster::fill(self : Cryptohashsha512Cluster, v : Double) -> Cryptohashsha512Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Cluster::min(self : Cryptohashsha512Cluster) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Cluster::max(self : Cryptohashsha512Cluster) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Cluster::to_string(self : Cryptohashsha512Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_model_make(size : Int) -> Cryptohashsha512Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Model::len(self : Cryptohashsha512Model) -> Int { self.size }

pub fn Cryptohashsha512Model::get(self : Cryptohashsha512Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Model::set(self : Cryptohashsha512Model, i : Int, v : Double) -> Cryptohashsha512Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Model::sum(self : Cryptohashsha512Model) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Model::mean(self : Cryptohashsha512Model) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Model::scale(self : Cryptohashsha512Model, f : Double) -> Cryptohashsha512Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Model::add(self : Cryptohashsha512Model, other : Cryptohashsha512Model) -> Cryptohashsha512Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Model::copy(self : Cryptohashsha512Model) -> Cryptohashsha512Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Model::fill(self : Cryptohashsha512Model, v : Double) -> Cryptohashsha512Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Model::min(self : Cryptohashsha512Model) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Model::max(self : Cryptohashsha512Model) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Model::to_string(self : Cryptohashsha512Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_layer_make(size : Int) -> Cryptohashsha512Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Layer::len(self : Cryptohashsha512Layer) -> Int { self.size }

pub fn Cryptohashsha512Layer::get(self : Cryptohashsha512Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Layer::set(self : Cryptohashsha512Layer, i : Int, v : Double) -> Cryptohashsha512Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Layer::sum(self : Cryptohashsha512Layer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Layer::mean(self : Cryptohashsha512Layer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Layer::scale(self : Cryptohashsha512Layer, f : Double) -> Cryptohashsha512Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Layer::add(self : Cryptohashsha512Layer, other : Cryptohashsha512Layer) -> Cryptohashsha512Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Layer::copy(self : Cryptohashsha512Layer) -> Cryptohashsha512Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Layer::fill(self : Cryptohashsha512Layer, v : Double) -> Cryptohashsha512Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Layer::min(self : Cryptohashsha512Layer) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Layer::max(self : Cryptohashsha512Layer) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Layer::to_string(self : Cryptohashsha512Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_buffer_make(size : Int) -> Cryptohashsha512Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Buffer::len(self : Cryptohashsha512Buffer) -> Int { self.size }

pub fn Cryptohashsha512Buffer::get(self : Cryptohashsha512Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Buffer::set(self : Cryptohashsha512Buffer, i : Int, v : Double) -> Cryptohashsha512Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Buffer::sum(self : Cryptohashsha512Buffer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Buffer::mean(self : Cryptohashsha512Buffer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Buffer::scale(self : Cryptohashsha512Buffer, f : Double) -> Cryptohashsha512Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Buffer::add(self : Cryptohashsha512Buffer, other : Cryptohashsha512Buffer) -> Cryptohashsha512Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Buffer::copy(self : Cryptohashsha512Buffer) -> Cryptohashsha512Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Buffer::fill(self : Cryptohashsha512Buffer, v : Double) -> Cryptohashsha512Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Buffer::min(self : Cryptohashsha512Buffer) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Buffer::max(self : Cryptohashsha512Buffer) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Buffer::to_string(self : Cryptohashsha512Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_cursor_make(size : Int) -> Cryptohashsha512Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Cursor::len(self : Cryptohashsha512Cursor) -> Int { self.size }

pub fn Cryptohashsha512Cursor::get(self : Cryptohashsha512Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Cursor::set(self : Cryptohashsha512Cursor, i : Int, v : Double) -> Cryptohashsha512Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Cursor::sum(self : Cryptohashsha512Cursor) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Cursor::mean(self : Cryptohashsha512Cursor) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Cursor::scale(self : Cryptohashsha512Cursor, f : Double) -> Cryptohashsha512Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Cursor::add(self : Cryptohashsha512Cursor, other : Cryptohashsha512Cursor) -> Cryptohashsha512Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Cursor::copy(self : Cryptohashsha512Cursor) -> Cryptohashsha512Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Cursor::fill(self : Cryptohashsha512Cursor, v : Double) -> Cryptohashsha512Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Cursor::min(self : Cryptohashsha512Cursor) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Cursor::max(self : Cryptohashsha512Cursor) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Cursor::to_string(self : Cryptohashsha512Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_view_make(size : Int) -> Cryptohashsha512View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512View::len(self : Cryptohashsha512View) -> Int { self.size }

pub fn Cryptohashsha512View::get(self : Cryptohashsha512View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512View::set(self : Cryptohashsha512View, i : Int, v : Double) -> Cryptohashsha512View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512View::sum(self : Cryptohashsha512View) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512View::mean(self : Cryptohashsha512View) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512View::scale(self : Cryptohashsha512View, f : Double) -> Cryptohashsha512View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512View::add(self : Cryptohashsha512View, other : Cryptohashsha512View) -> Cryptohashsha512View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512View::copy(self : Cryptohashsha512View) -> Cryptohashsha512View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512View::fill(self : Cryptohashsha512View, v : Double) -> Cryptohashsha512View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512View::min(self : Cryptohashsha512View) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512View::max(self : Cryptohashsha512View) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512View::to_string(self : Cryptohashsha512View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_range_make(size : Int) -> Cryptohashsha512Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Range::len(self : Cryptohashsha512Range) -> Int { self.size }

pub fn Cryptohashsha512Range::get(self : Cryptohashsha512Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Range::set(self : Cryptohashsha512Range, i : Int, v : Double) -> Cryptohashsha512Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Range::sum(self : Cryptohashsha512Range) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Range::mean(self : Cryptohashsha512Range) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Range::scale(self : Cryptohashsha512Range, f : Double) -> Cryptohashsha512Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Range::add(self : Cryptohashsha512Range, other : Cryptohashsha512Range) -> Cryptohashsha512Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Range::copy(self : Cryptohashsha512Range) -> Cryptohashsha512Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Range::fill(self : Cryptohashsha512Range, v : Double) -> Cryptohashsha512Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Range::min(self : Cryptohashsha512Range) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Range::max(self : Cryptohashsha512Range) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Range::to_string(self : Cryptohashsha512Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_slice_make(size : Int) -> Cryptohashsha512Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha512Slice::len(self : Cryptohashsha512Slice) -> Int { self.size }

pub fn Cryptohashsha512Slice::get(self : Cryptohashsha512Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha512Slice::set(self : Cryptohashsha512Slice, i : Int, v : Double) -> Cryptohashsha512Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Slice::sum(self : Cryptohashsha512Slice) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha512Slice::mean(self : Cryptohashsha512Slice) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha512Slice::scale(self : Cryptohashsha512Slice, f : Double) -> Cryptohashsha512Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Slice::add(self : Cryptohashsha512Slice, other : Cryptohashsha512Slice) -> Cryptohashsha512Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha512Slice::copy(self : Cryptohashsha512Slice) -> Cryptohashsha512Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Slice::fill(self : Cryptohashsha512Slice, v : Double) -> Cryptohashsha512Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha512Slice::min(self : Cryptohashsha512Slice) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha512Slice::max(self : Cryptohashsha512Slice) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha512Slice::to_string(self : Cryptohashsha512Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

