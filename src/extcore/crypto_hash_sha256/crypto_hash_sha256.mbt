///===
/// extcore/crypto_hash_sha256

pub(all) struct Cryptohashsha256Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha256_make_point(x : Double, y : Double) -> Cryptohashsha256Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha256_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha256Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashsha256Point::x(self : Cryptohashsha256Point) -> Double { self.x }

pub fn Cryptohashsha256Point::y(self : Cryptohashsha256Point) -> Double { self.y }

pub fn Cryptohashsha256Point::z(self : Cryptohashsha256Point) -> Double { self.z }

pub fn Cryptohashsha256Point::label(self : Cryptohashsha256Point) -> Int { self.label }

pub fn Cryptohashsha256Point::dist(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashsha256Point::add(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashsha256Point::sub(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashsha256Point::scale(self : Cryptohashsha256Point, s : Double) -> Cryptohashsha256Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashsha256Point::dot(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashsha256Point::cross(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashsha256Point::norm(self : Cryptohashsha256Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashsha256Point::normalize(self : Cryptohashsha256Point) -> Cryptohashsha256Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha256Point::negate(self : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashsha256Point::mid(self : Cryptohashsha256Point, other : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashsha256Point::lerp(self : Cryptohashsha256Point, other : Cryptohashsha256Point, t : Double) -> Cryptohashsha256Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashsha256Point::to_string(self : Cryptohashsha256Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashsha256Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha256_make_series(vals : Array[Double], name : String) -> Cryptohashsha256Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashsha256Series::len(self : Cryptohashsha256Series) -> Int { self.vals.length() }

pub fn Cryptohashsha256Series::sum(self : Cryptohashsha256Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashsha256Series::mean(self : Cryptohashsha256Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashsha256Series::min(self : Cryptohashsha256Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashsha256Series::max(self : Cryptohashsha256Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashsha256Series::range(self : Cryptohashsha256Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashsha256Series::variance(self : Cryptohashsha256Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashsha256Series::std(self : Cryptohashsha256Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashsha256Series::median(self : Cryptohashsha256Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashsha256Series::scale(self : Cryptohashsha256Series, f : Double) -> Cryptohashsha256Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashsha256Series::add(self : Cryptohashsha256Series, other : Cryptohashsha256Series) -> Cryptohashsha256Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashsha256Series::sub(self : Cryptohashsha256Series, other : Cryptohashsha256Series) -> Cryptohashsha256Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashsha256Series::normalize(self : Cryptohashsha256Series) -> Cryptohashsha256Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashsha256Series::cumsum(self : Cryptohashsha256Series) -> Cryptohashsha256Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashsha256Series::to_string(self : Cryptohashsha256Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha256Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha256_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha256Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha256_matrix_identity(n : Int) -> Cryptohashsha256Matrix {
  let m = crypto_hash_sha256_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashsha256Matrix::get(self : Cryptohashsha256Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashsha256Matrix::transpose(self : Cryptohashsha256Matrix) -> Cryptohashsha256Matrix {
  let result = crypto_hash_sha256_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashsha256Matrix::add(self : Cryptohashsha256Matrix, other : Cryptohashsha256Matrix) -> Cryptohashsha256Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_sha256_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashsha256Matrix::scale(self : Cryptohashsha256Matrix, s : Double) -> Cryptohashsha256Matrix {
  let result = crypto_hash_sha256_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashsha256Matrix::multiply(self : Cryptohashsha256Matrix, other : Cryptohashsha256Matrix) -> Cryptohashsha256Matrix {
  if self.cols != other.rows { return crypto_hash_sha256_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_sha256_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Cryptohashsha256Matrix::trace(self : Cryptohashsha256Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashsha256Matrix::det(self : Cryptohashsha256Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashsha256Matrix::norm(self : Cryptohashsha256Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashsha256Matrix::to_string(self : Cryptohashsha256Matrix) -> String {
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

pub(all) struct Cryptohashsha256Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha256_make_vector(comps : Array[Double]) -> Cryptohashsha256Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha256_vector_zero(dim : Int) -> Cryptohashsha256Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashsha256Vector::add(self : Cryptohashsha256Vector, other : Cryptohashsha256Vector) -> Cryptohashsha256Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha256Vector::sub(self : Cryptohashsha256Vector, other : Cryptohashsha256Vector) -> Cryptohashsha256Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashsha256Vector::scale(self : Cryptohashsha256Vector, s : Double) -> Cryptohashsha256Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashsha256Vector::dot(self : Cryptohashsha256Vector, other : Cryptohashsha256Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashsha256Vector::norm(self : Cryptohashsha256Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashsha256Vector::normalize(self : Cryptohashsha256Vector) -> Cryptohashsha256Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashsha256Vector::dist(self : Cryptohashsha256Vector, other : Cryptohashsha256Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashsha256Vector::to_string(self : Cryptohashsha256Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha256Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_frame_make(size : Int) -> Cryptohashsha256Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Frame::len(self : Cryptohashsha256Frame) -> Int { self.size }

pub fn Cryptohashsha256Frame::get(self : Cryptohashsha256Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Frame::set(self : Cryptohashsha256Frame, i : Int, v : Double) -> Cryptohashsha256Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Frame::sum(self : Cryptohashsha256Frame) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Frame::mean(self : Cryptohashsha256Frame) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Frame::scale(self : Cryptohashsha256Frame, f : Double) -> Cryptohashsha256Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Frame::add(self : Cryptohashsha256Frame, other : Cryptohashsha256Frame) -> Cryptohashsha256Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Frame::copy(self : Cryptohashsha256Frame) -> Cryptohashsha256Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Frame::fill(self : Cryptohashsha256Frame, v : Double) -> Cryptohashsha256Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Frame::min(self : Cryptohashsha256Frame) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Frame::max(self : Cryptohashsha256Frame) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Frame::to_string(self : Cryptohashsha256Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_table_make(size : Int) -> Cryptohashsha256Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Table::len(self : Cryptohashsha256Table) -> Int { self.size }

pub fn Cryptohashsha256Table::get(self : Cryptohashsha256Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Table::set(self : Cryptohashsha256Table, i : Int, v : Double) -> Cryptohashsha256Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Table::sum(self : Cryptohashsha256Table) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Table::mean(self : Cryptohashsha256Table) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Table::scale(self : Cryptohashsha256Table, f : Double) -> Cryptohashsha256Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Table::add(self : Cryptohashsha256Table, other : Cryptohashsha256Table) -> Cryptohashsha256Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Table::copy(self : Cryptohashsha256Table) -> Cryptohashsha256Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Table::fill(self : Cryptohashsha256Table, v : Double) -> Cryptohashsha256Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Table::min(self : Cryptohashsha256Table) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Table::max(self : Cryptohashsha256Table) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Table::to_string(self : Cryptohashsha256Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_graphn_make(size : Int) -> Cryptohashsha256GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256GraphN::len(self : Cryptohashsha256GraphN) -> Int { self.size }

pub fn Cryptohashsha256GraphN::get(self : Cryptohashsha256GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256GraphN::set(self : Cryptohashsha256GraphN, i : Int, v : Double) -> Cryptohashsha256GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256GraphN::sum(self : Cryptohashsha256GraphN) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256GraphN::mean(self : Cryptohashsha256GraphN) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256GraphN::scale(self : Cryptohashsha256GraphN, f : Double) -> Cryptohashsha256GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256GraphN::add(self : Cryptohashsha256GraphN, other : Cryptohashsha256GraphN) -> Cryptohashsha256GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256GraphN::copy(self : Cryptohashsha256GraphN) -> Cryptohashsha256GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256GraphN::fill(self : Cryptohashsha256GraphN, v : Double) -> Cryptohashsha256GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256GraphN::min(self : Cryptohashsha256GraphN) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256GraphN::max(self : Cryptohashsha256GraphN) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256GraphN::to_string(self : Cryptohashsha256GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_node_make(size : Int) -> Cryptohashsha256Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Node::len(self : Cryptohashsha256Node) -> Int { self.size }

pub fn Cryptohashsha256Node::get(self : Cryptohashsha256Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Node::set(self : Cryptohashsha256Node, i : Int, v : Double) -> Cryptohashsha256Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Node::sum(self : Cryptohashsha256Node) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Node::mean(self : Cryptohashsha256Node) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Node::scale(self : Cryptohashsha256Node, f : Double) -> Cryptohashsha256Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Node::add(self : Cryptohashsha256Node, other : Cryptohashsha256Node) -> Cryptohashsha256Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Node::copy(self : Cryptohashsha256Node) -> Cryptohashsha256Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Node::fill(self : Cryptohashsha256Node, v : Double) -> Cryptohashsha256Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Node::min(self : Cryptohashsha256Node) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Node::max(self : Cryptohashsha256Node) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Node::to_string(self : Cryptohashsha256Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_edge_make(size : Int) -> Cryptohashsha256Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Edge::len(self : Cryptohashsha256Edge) -> Int { self.size }

pub fn Cryptohashsha256Edge::get(self : Cryptohashsha256Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Edge::set(self : Cryptohashsha256Edge, i : Int, v : Double) -> Cryptohashsha256Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Edge::sum(self : Cryptohashsha256Edge) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Edge::mean(self : Cryptohashsha256Edge) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Edge::scale(self : Cryptohashsha256Edge, f : Double) -> Cryptohashsha256Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Edge::add(self : Cryptohashsha256Edge, other : Cryptohashsha256Edge) -> Cryptohashsha256Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Edge::copy(self : Cryptohashsha256Edge) -> Cryptohashsha256Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Edge::fill(self : Cryptohashsha256Edge, v : Double) -> Cryptohashsha256Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Edge::min(self : Cryptohashsha256Edge) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Edge::max(self : Cryptohashsha256Edge) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Edge::to_string(self : Cryptohashsha256Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_path_make(size : Int) -> Cryptohashsha256Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Path::len(self : Cryptohashsha256Path) -> Int { self.size }

pub fn Cryptohashsha256Path::get(self : Cryptohashsha256Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Path::set(self : Cryptohashsha256Path, i : Int, v : Double) -> Cryptohashsha256Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Path::sum(self : Cryptohashsha256Path) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Path::mean(self : Cryptohashsha256Path) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Path::scale(self : Cryptohashsha256Path, f : Double) -> Cryptohashsha256Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Path::add(self : Cryptohashsha256Path, other : Cryptohashsha256Path) -> Cryptohashsha256Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Path::copy(self : Cryptohashsha256Path) -> Cryptohashsha256Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Path::fill(self : Cryptohashsha256Path, v : Double) -> Cryptohashsha256Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Path::min(self : Cryptohashsha256Path) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Path::max(self : Cryptohashsha256Path) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Path::to_string(self : Cryptohashsha256Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_cluster_make(size : Int) -> Cryptohashsha256Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Cluster::len(self : Cryptohashsha256Cluster) -> Int { self.size }

pub fn Cryptohashsha256Cluster::get(self : Cryptohashsha256Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Cluster::set(self : Cryptohashsha256Cluster, i : Int, v : Double) -> Cryptohashsha256Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Cluster::sum(self : Cryptohashsha256Cluster) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Cluster::mean(self : Cryptohashsha256Cluster) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Cluster::scale(self : Cryptohashsha256Cluster, f : Double) -> Cryptohashsha256Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Cluster::add(self : Cryptohashsha256Cluster, other : Cryptohashsha256Cluster) -> Cryptohashsha256Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Cluster::copy(self : Cryptohashsha256Cluster) -> Cryptohashsha256Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Cluster::fill(self : Cryptohashsha256Cluster, v : Double) -> Cryptohashsha256Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Cluster::min(self : Cryptohashsha256Cluster) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Cluster::max(self : Cryptohashsha256Cluster) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Cluster::to_string(self : Cryptohashsha256Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_model_make(size : Int) -> Cryptohashsha256Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Model::len(self : Cryptohashsha256Model) -> Int { self.size }

pub fn Cryptohashsha256Model::get(self : Cryptohashsha256Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Model::set(self : Cryptohashsha256Model, i : Int, v : Double) -> Cryptohashsha256Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Model::sum(self : Cryptohashsha256Model) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Model::mean(self : Cryptohashsha256Model) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Model::scale(self : Cryptohashsha256Model, f : Double) -> Cryptohashsha256Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Model::add(self : Cryptohashsha256Model, other : Cryptohashsha256Model) -> Cryptohashsha256Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Model::copy(self : Cryptohashsha256Model) -> Cryptohashsha256Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Model::fill(self : Cryptohashsha256Model, v : Double) -> Cryptohashsha256Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Model::min(self : Cryptohashsha256Model) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Model::max(self : Cryptohashsha256Model) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Model::to_string(self : Cryptohashsha256Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_layer_make(size : Int) -> Cryptohashsha256Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Layer::len(self : Cryptohashsha256Layer) -> Int { self.size }

pub fn Cryptohashsha256Layer::get(self : Cryptohashsha256Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Layer::set(self : Cryptohashsha256Layer, i : Int, v : Double) -> Cryptohashsha256Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Layer::sum(self : Cryptohashsha256Layer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Layer::mean(self : Cryptohashsha256Layer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Layer::scale(self : Cryptohashsha256Layer, f : Double) -> Cryptohashsha256Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Layer::add(self : Cryptohashsha256Layer, other : Cryptohashsha256Layer) -> Cryptohashsha256Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Layer::copy(self : Cryptohashsha256Layer) -> Cryptohashsha256Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Layer::fill(self : Cryptohashsha256Layer, v : Double) -> Cryptohashsha256Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Layer::min(self : Cryptohashsha256Layer) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Layer::max(self : Cryptohashsha256Layer) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Layer::to_string(self : Cryptohashsha256Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_buffer_make(size : Int) -> Cryptohashsha256Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Buffer::len(self : Cryptohashsha256Buffer) -> Int { self.size }

pub fn Cryptohashsha256Buffer::get(self : Cryptohashsha256Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Buffer::set(self : Cryptohashsha256Buffer, i : Int, v : Double) -> Cryptohashsha256Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Buffer::sum(self : Cryptohashsha256Buffer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Buffer::mean(self : Cryptohashsha256Buffer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Buffer::scale(self : Cryptohashsha256Buffer, f : Double) -> Cryptohashsha256Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Buffer::add(self : Cryptohashsha256Buffer, other : Cryptohashsha256Buffer) -> Cryptohashsha256Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Buffer::copy(self : Cryptohashsha256Buffer) -> Cryptohashsha256Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Buffer::fill(self : Cryptohashsha256Buffer, v : Double) -> Cryptohashsha256Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Buffer::min(self : Cryptohashsha256Buffer) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Buffer::max(self : Cryptohashsha256Buffer) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Buffer::to_string(self : Cryptohashsha256Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_cursor_make(size : Int) -> Cryptohashsha256Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Cursor::len(self : Cryptohashsha256Cursor) -> Int { self.size }

pub fn Cryptohashsha256Cursor::get(self : Cryptohashsha256Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Cursor::set(self : Cryptohashsha256Cursor, i : Int, v : Double) -> Cryptohashsha256Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Cursor::sum(self : Cryptohashsha256Cursor) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Cursor::mean(self : Cryptohashsha256Cursor) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Cursor::scale(self : Cryptohashsha256Cursor, f : Double) -> Cryptohashsha256Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Cursor::add(self : Cryptohashsha256Cursor, other : Cryptohashsha256Cursor) -> Cryptohashsha256Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Cursor::copy(self : Cryptohashsha256Cursor) -> Cryptohashsha256Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Cursor::fill(self : Cryptohashsha256Cursor, v : Double) -> Cryptohashsha256Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Cursor::min(self : Cryptohashsha256Cursor) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Cursor::max(self : Cryptohashsha256Cursor) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Cursor::to_string(self : Cryptohashsha256Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_view_make(size : Int) -> Cryptohashsha256View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256View::len(self : Cryptohashsha256View) -> Int { self.size }

pub fn Cryptohashsha256View::get(self : Cryptohashsha256View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256View::set(self : Cryptohashsha256View, i : Int, v : Double) -> Cryptohashsha256View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256View::sum(self : Cryptohashsha256View) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256View::mean(self : Cryptohashsha256View) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256View::scale(self : Cryptohashsha256View, f : Double) -> Cryptohashsha256View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256View::add(self : Cryptohashsha256View, other : Cryptohashsha256View) -> Cryptohashsha256View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256View::copy(self : Cryptohashsha256View) -> Cryptohashsha256View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256View::fill(self : Cryptohashsha256View, v : Double) -> Cryptohashsha256View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256View::min(self : Cryptohashsha256View) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256View::max(self : Cryptohashsha256View) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256View::to_string(self : Cryptohashsha256View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_range_make(size : Int) -> Cryptohashsha256Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Range::len(self : Cryptohashsha256Range) -> Int { self.size }

pub fn Cryptohashsha256Range::get(self : Cryptohashsha256Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Range::set(self : Cryptohashsha256Range, i : Int, v : Double) -> Cryptohashsha256Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Range::sum(self : Cryptohashsha256Range) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Range::mean(self : Cryptohashsha256Range) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Range::scale(self : Cryptohashsha256Range, f : Double) -> Cryptohashsha256Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Range::add(self : Cryptohashsha256Range, other : Cryptohashsha256Range) -> Cryptohashsha256Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Range::copy(self : Cryptohashsha256Range) -> Cryptohashsha256Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Range::fill(self : Cryptohashsha256Range, v : Double) -> Cryptohashsha256Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Range::min(self : Cryptohashsha256Range) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Range::max(self : Cryptohashsha256Range) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Range::to_string(self : Cryptohashsha256Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_slice_make(size : Int) -> Cryptohashsha256Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashsha256Slice::len(self : Cryptohashsha256Slice) -> Int { self.size }

pub fn Cryptohashsha256Slice::get(self : Cryptohashsha256Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashsha256Slice::set(self : Cryptohashsha256Slice, i : Int, v : Double) -> Cryptohashsha256Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Slice::sum(self : Cryptohashsha256Slice) -> Double { @_common.sum(self.data) }

pub fn Cryptohashsha256Slice::mean(self : Cryptohashsha256Slice) -> Double { @_common.mean(self.data) }

pub fn Cryptohashsha256Slice::scale(self : Cryptohashsha256Slice, f : Double) -> Cryptohashsha256Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Slice::add(self : Cryptohashsha256Slice, other : Cryptohashsha256Slice) -> Cryptohashsha256Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashsha256Slice::copy(self : Cryptohashsha256Slice) -> Cryptohashsha256Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Slice::fill(self : Cryptohashsha256Slice, v : Double) -> Cryptohashsha256Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashsha256Slice::min(self : Cryptohashsha256Slice) -> Double { @_common.min(self.data) }

pub fn Cryptohashsha256Slice::max(self : Cryptohashsha256Slice) -> Double { @_common.max(self.data) }

pub fn Cryptohashsha256Slice::to_string(self : Cryptohashsha256Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

