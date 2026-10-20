///===
/// extcore/opt_convex_sr1

pub(all) struct Optconvexsr1Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_sr1_make_point(x : Double, y : Double) -> Optconvexsr1Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_sr1_make_point3(x : Double, y : Double, z : Double) -> Optconvexsr1Point {
  { x, y, z, label: 0 }
}

pub fn Optconvexsr1Point::x(self : Optconvexsr1Point) -> Double { self.x }

pub fn Optconvexsr1Point::y(self : Optconvexsr1Point) -> Double { self.y }

pub fn Optconvexsr1Point::z(self : Optconvexsr1Point) -> Double { self.z }

pub fn Optconvexsr1Point::label(self : Optconvexsr1Point) -> Int { self.label }

pub fn Optconvexsr1Point::dist(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Optconvexsr1Point::add(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Optconvexsr1Point::sub(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Optconvexsr1Point::scale(self : Optconvexsr1Point, s : Double) -> Optconvexsr1Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Optconvexsr1Point::dot(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Optconvexsr1Point::cross(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Optconvexsr1Point::norm(self : Optconvexsr1Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Optconvexsr1Point::normalize(self : Optconvexsr1Point) -> Optconvexsr1Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Optconvexsr1Point::negate(self : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Optconvexsr1Point::mid(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Optconvexsr1Point::lerp(self : Optconvexsr1Point, other : Optconvexsr1Point, t : Double) -> Optconvexsr1Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Optconvexsr1Point::to_string(self : Optconvexsr1Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Optconvexsr1Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_sr1_make_series(vals : Array[Double], name : String) -> Optconvexsr1Series {
  { vals, name, meta: 0 }
}

pub fn Optconvexsr1Series::len(self : Optconvexsr1Series) -> Int { self.vals.length() }

pub fn Optconvexsr1Series::sum(self : Optconvexsr1Series) -> Double { @_common.sum(self.vals) }

pub fn Optconvexsr1Series::mean(self : Optconvexsr1Series) -> Double { @_common.mean(self.vals) }

pub fn Optconvexsr1Series::min(self : Optconvexsr1Series) -> Double { @_common.min(self.vals) }

pub fn Optconvexsr1Series::max(self : Optconvexsr1Series) -> Double { @_common.max(self.vals) }

pub fn Optconvexsr1Series::range(self : Optconvexsr1Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Optconvexsr1Series::variance(self : Optconvexsr1Series) -> Double { @_common.variance(self.vals) }

pub fn Optconvexsr1Series::std(self : Optconvexsr1Series) -> Double { @_common.std(self.vals) }

pub fn Optconvexsr1Series::median(self : Optconvexsr1Series) -> Double { @_common.median(self.vals) }

pub fn Optconvexsr1Series::scale(self : Optconvexsr1Series, f : Double) -> Optconvexsr1Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Optconvexsr1Series::add(self : Optconvexsr1Series, other : Optconvexsr1Series) -> Optconvexsr1Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Optconvexsr1Series::sub(self : Optconvexsr1Series, other : Optconvexsr1Series) -> Optconvexsr1Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Optconvexsr1Series::normalize(self : Optconvexsr1Series) -> Optconvexsr1Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Optconvexsr1Series::cumsum(self : Optconvexsr1Series) -> Optconvexsr1Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Optconvexsr1Series::to_string(self : Optconvexsr1Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Optconvexsr1Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_sr1_make_matrix(rows : Int, cols : Int, val : Double) -> Optconvexsr1Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_sr1_matrix_identity(n : Int) -> Optconvexsr1Matrix {
  let m = opt_convex_sr1_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Optconvexsr1Matrix::get(self : Optconvexsr1Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Optconvexsr1Matrix::transpose(self : Optconvexsr1Matrix) -> Optconvexsr1Matrix {
  let result = opt_convex_sr1_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Optconvexsr1Matrix::add(self : Optconvexsr1Matrix, other : Optconvexsr1Matrix) -> Optconvexsr1Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_sr1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Optconvexsr1Matrix::scale(self : Optconvexsr1Matrix, s : Double) -> Optconvexsr1Matrix {
  let result = opt_convex_sr1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Optconvexsr1Matrix::multiply(self : Optconvexsr1Matrix, other : Optconvexsr1Matrix) -> Optconvexsr1Matrix {
  if self.cols != other.rows { return opt_convex_sr1_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_sr1_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Optconvexsr1Matrix::trace(self : Optconvexsr1Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Optconvexsr1Matrix::det(self : Optconvexsr1Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Optconvexsr1Matrix::norm(self : Optconvexsr1Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Optconvexsr1Matrix::to_string(self : Optconvexsr1Matrix) -> String {
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

pub(all) struct Optconvexsr1Vector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_sr1_make_vector(comps : Array[Double]) -> Optconvexsr1Vector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_sr1_vector_zero(dim : Int) -> Optconvexsr1Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Optconvexsr1Vector::add(self : Optconvexsr1Vector, other : Optconvexsr1Vector) -> Optconvexsr1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Optconvexsr1Vector::sub(self : Optconvexsr1Vector, other : Optconvexsr1Vector) -> Optconvexsr1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Optconvexsr1Vector::scale(self : Optconvexsr1Vector, s : Double) -> Optconvexsr1Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Optconvexsr1Vector::dot(self : Optconvexsr1Vector, other : Optconvexsr1Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Optconvexsr1Vector::norm(self : Optconvexsr1Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Optconvexsr1Vector::normalize(self : Optconvexsr1Vector) -> Optconvexsr1Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Optconvexsr1Vector::dist(self : Optconvexsr1Vector, other : Optconvexsr1Vector) -> Double {
  self.sub(other).norm()
}

pub fn Optconvexsr1Vector::to_string(self : Optconvexsr1Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Optconvexsr1Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_frame_make(size : Int) -> Optconvexsr1Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Frame::len(self : Optconvexsr1Frame) -> Int { self.size }

pub fn Optconvexsr1Frame::get(self : Optconvexsr1Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Frame::set(self : Optconvexsr1Frame, i : Int, v : Double) -> Optconvexsr1Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Frame::sum(self : Optconvexsr1Frame) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Frame::mean(self : Optconvexsr1Frame) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Frame::scale(self : Optconvexsr1Frame, f : Double) -> Optconvexsr1Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Frame::add(self : Optconvexsr1Frame, other : Optconvexsr1Frame) -> Optconvexsr1Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Frame::copy(self : Optconvexsr1Frame) -> Optconvexsr1Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Frame::fill(self : Optconvexsr1Frame, v : Double) -> Optconvexsr1Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Frame::min(self : Optconvexsr1Frame) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Frame::max(self : Optconvexsr1Frame) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Frame::to_string(self : Optconvexsr1Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_table_make(size : Int) -> Optconvexsr1Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Table::len(self : Optconvexsr1Table) -> Int { self.size }

pub fn Optconvexsr1Table::get(self : Optconvexsr1Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Table::set(self : Optconvexsr1Table, i : Int, v : Double) -> Optconvexsr1Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Table::sum(self : Optconvexsr1Table) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Table::mean(self : Optconvexsr1Table) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Table::scale(self : Optconvexsr1Table, f : Double) -> Optconvexsr1Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Table::add(self : Optconvexsr1Table, other : Optconvexsr1Table) -> Optconvexsr1Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Table::copy(self : Optconvexsr1Table) -> Optconvexsr1Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Table::fill(self : Optconvexsr1Table, v : Double) -> Optconvexsr1Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Table::min(self : Optconvexsr1Table) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Table::max(self : Optconvexsr1Table) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Table::to_string(self : Optconvexsr1Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_graphn_make(size : Int) -> Optconvexsr1GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1GraphN::len(self : Optconvexsr1GraphN) -> Int { self.size }

pub fn Optconvexsr1GraphN::get(self : Optconvexsr1GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1GraphN::set(self : Optconvexsr1GraphN, i : Int, v : Double) -> Optconvexsr1GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1GraphN::sum(self : Optconvexsr1GraphN) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1GraphN::mean(self : Optconvexsr1GraphN) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1GraphN::scale(self : Optconvexsr1GraphN, f : Double) -> Optconvexsr1GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1GraphN::add(self : Optconvexsr1GraphN, other : Optconvexsr1GraphN) -> Optconvexsr1GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1GraphN::copy(self : Optconvexsr1GraphN) -> Optconvexsr1GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1GraphN::fill(self : Optconvexsr1GraphN, v : Double) -> Optconvexsr1GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1GraphN::min(self : Optconvexsr1GraphN) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1GraphN::max(self : Optconvexsr1GraphN) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1GraphN::to_string(self : Optconvexsr1GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_node_make(size : Int) -> Optconvexsr1Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Node::len(self : Optconvexsr1Node) -> Int { self.size }

pub fn Optconvexsr1Node::get(self : Optconvexsr1Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Node::set(self : Optconvexsr1Node, i : Int, v : Double) -> Optconvexsr1Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Node::sum(self : Optconvexsr1Node) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Node::mean(self : Optconvexsr1Node) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Node::scale(self : Optconvexsr1Node, f : Double) -> Optconvexsr1Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Node::add(self : Optconvexsr1Node, other : Optconvexsr1Node) -> Optconvexsr1Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Node::copy(self : Optconvexsr1Node) -> Optconvexsr1Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Node::fill(self : Optconvexsr1Node, v : Double) -> Optconvexsr1Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Node::min(self : Optconvexsr1Node) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Node::max(self : Optconvexsr1Node) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Node::to_string(self : Optconvexsr1Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_edge_make(size : Int) -> Optconvexsr1Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Edge::len(self : Optconvexsr1Edge) -> Int { self.size }

pub fn Optconvexsr1Edge::get(self : Optconvexsr1Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Edge::set(self : Optconvexsr1Edge, i : Int, v : Double) -> Optconvexsr1Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Edge::sum(self : Optconvexsr1Edge) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Edge::mean(self : Optconvexsr1Edge) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Edge::scale(self : Optconvexsr1Edge, f : Double) -> Optconvexsr1Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Edge::add(self : Optconvexsr1Edge, other : Optconvexsr1Edge) -> Optconvexsr1Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Edge::copy(self : Optconvexsr1Edge) -> Optconvexsr1Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Edge::fill(self : Optconvexsr1Edge, v : Double) -> Optconvexsr1Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Edge::min(self : Optconvexsr1Edge) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Edge::max(self : Optconvexsr1Edge) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Edge::to_string(self : Optconvexsr1Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_path_make(size : Int) -> Optconvexsr1Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Path::len(self : Optconvexsr1Path) -> Int { self.size }

pub fn Optconvexsr1Path::get(self : Optconvexsr1Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Path::set(self : Optconvexsr1Path, i : Int, v : Double) -> Optconvexsr1Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Path::sum(self : Optconvexsr1Path) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Path::mean(self : Optconvexsr1Path) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Path::scale(self : Optconvexsr1Path, f : Double) -> Optconvexsr1Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Path::add(self : Optconvexsr1Path, other : Optconvexsr1Path) -> Optconvexsr1Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Path::copy(self : Optconvexsr1Path) -> Optconvexsr1Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Path::fill(self : Optconvexsr1Path, v : Double) -> Optconvexsr1Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Path::min(self : Optconvexsr1Path) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Path::max(self : Optconvexsr1Path) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Path::to_string(self : Optconvexsr1Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_cluster_make(size : Int) -> Optconvexsr1Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Cluster::len(self : Optconvexsr1Cluster) -> Int { self.size }

pub fn Optconvexsr1Cluster::get(self : Optconvexsr1Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Cluster::set(self : Optconvexsr1Cluster, i : Int, v : Double) -> Optconvexsr1Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Cluster::sum(self : Optconvexsr1Cluster) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Cluster::mean(self : Optconvexsr1Cluster) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Cluster::scale(self : Optconvexsr1Cluster, f : Double) -> Optconvexsr1Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Cluster::add(self : Optconvexsr1Cluster, other : Optconvexsr1Cluster) -> Optconvexsr1Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Cluster::copy(self : Optconvexsr1Cluster) -> Optconvexsr1Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Cluster::fill(self : Optconvexsr1Cluster, v : Double) -> Optconvexsr1Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Cluster::min(self : Optconvexsr1Cluster) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Cluster::max(self : Optconvexsr1Cluster) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Cluster::to_string(self : Optconvexsr1Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_model_make(size : Int) -> Optconvexsr1Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Model::len(self : Optconvexsr1Model) -> Int { self.size }

pub fn Optconvexsr1Model::get(self : Optconvexsr1Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Model::set(self : Optconvexsr1Model, i : Int, v : Double) -> Optconvexsr1Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Model::sum(self : Optconvexsr1Model) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Model::mean(self : Optconvexsr1Model) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Model::scale(self : Optconvexsr1Model, f : Double) -> Optconvexsr1Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Model::add(self : Optconvexsr1Model, other : Optconvexsr1Model) -> Optconvexsr1Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Model::copy(self : Optconvexsr1Model) -> Optconvexsr1Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Model::fill(self : Optconvexsr1Model, v : Double) -> Optconvexsr1Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Model::min(self : Optconvexsr1Model) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Model::max(self : Optconvexsr1Model) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Model::to_string(self : Optconvexsr1Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_layer_make(size : Int) -> Optconvexsr1Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Layer::len(self : Optconvexsr1Layer) -> Int { self.size }

pub fn Optconvexsr1Layer::get(self : Optconvexsr1Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Layer::set(self : Optconvexsr1Layer, i : Int, v : Double) -> Optconvexsr1Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Layer::sum(self : Optconvexsr1Layer) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Layer::mean(self : Optconvexsr1Layer) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Layer::scale(self : Optconvexsr1Layer, f : Double) -> Optconvexsr1Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Layer::add(self : Optconvexsr1Layer, other : Optconvexsr1Layer) -> Optconvexsr1Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Layer::copy(self : Optconvexsr1Layer) -> Optconvexsr1Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Layer::fill(self : Optconvexsr1Layer, v : Double) -> Optconvexsr1Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Layer::min(self : Optconvexsr1Layer) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Layer::max(self : Optconvexsr1Layer) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Layer::to_string(self : Optconvexsr1Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_buffer_make(size : Int) -> Optconvexsr1Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Buffer::len(self : Optconvexsr1Buffer) -> Int { self.size }

pub fn Optconvexsr1Buffer::get(self : Optconvexsr1Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Buffer::set(self : Optconvexsr1Buffer, i : Int, v : Double) -> Optconvexsr1Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Buffer::sum(self : Optconvexsr1Buffer) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Buffer::mean(self : Optconvexsr1Buffer) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Buffer::scale(self : Optconvexsr1Buffer, f : Double) -> Optconvexsr1Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Buffer::add(self : Optconvexsr1Buffer, other : Optconvexsr1Buffer) -> Optconvexsr1Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Buffer::copy(self : Optconvexsr1Buffer) -> Optconvexsr1Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Buffer::fill(self : Optconvexsr1Buffer, v : Double) -> Optconvexsr1Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Buffer::min(self : Optconvexsr1Buffer) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Buffer::max(self : Optconvexsr1Buffer) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Buffer::to_string(self : Optconvexsr1Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_cursor_make(size : Int) -> Optconvexsr1Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Cursor::len(self : Optconvexsr1Cursor) -> Int { self.size }

pub fn Optconvexsr1Cursor::get(self : Optconvexsr1Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Cursor::set(self : Optconvexsr1Cursor, i : Int, v : Double) -> Optconvexsr1Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Cursor::sum(self : Optconvexsr1Cursor) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Cursor::mean(self : Optconvexsr1Cursor) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Cursor::scale(self : Optconvexsr1Cursor, f : Double) -> Optconvexsr1Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Cursor::add(self : Optconvexsr1Cursor, other : Optconvexsr1Cursor) -> Optconvexsr1Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Cursor::copy(self : Optconvexsr1Cursor) -> Optconvexsr1Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Cursor::fill(self : Optconvexsr1Cursor, v : Double) -> Optconvexsr1Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Cursor::min(self : Optconvexsr1Cursor) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Cursor::max(self : Optconvexsr1Cursor) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Cursor::to_string(self : Optconvexsr1Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_view_make(size : Int) -> Optconvexsr1View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1View::len(self : Optconvexsr1View) -> Int { self.size }

pub fn Optconvexsr1View::get(self : Optconvexsr1View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1View::set(self : Optconvexsr1View, i : Int, v : Double) -> Optconvexsr1View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1View::sum(self : Optconvexsr1View) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1View::mean(self : Optconvexsr1View) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1View::scale(self : Optconvexsr1View, f : Double) -> Optconvexsr1View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1View::add(self : Optconvexsr1View, other : Optconvexsr1View) -> Optconvexsr1View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1View::copy(self : Optconvexsr1View) -> Optconvexsr1View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1View::fill(self : Optconvexsr1View, v : Double) -> Optconvexsr1View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1View::min(self : Optconvexsr1View) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1View::max(self : Optconvexsr1View) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1View::to_string(self : Optconvexsr1View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_range_make(size : Int) -> Optconvexsr1Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Range::len(self : Optconvexsr1Range) -> Int { self.size }

pub fn Optconvexsr1Range::get(self : Optconvexsr1Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Range::set(self : Optconvexsr1Range, i : Int, v : Double) -> Optconvexsr1Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Range::sum(self : Optconvexsr1Range) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Range::mean(self : Optconvexsr1Range) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Range::scale(self : Optconvexsr1Range, f : Double) -> Optconvexsr1Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Range::add(self : Optconvexsr1Range, other : Optconvexsr1Range) -> Optconvexsr1Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Range::copy(self : Optconvexsr1Range) -> Optconvexsr1Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Range::fill(self : Optconvexsr1Range, v : Double) -> Optconvexsr1Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Range::min(self : Optconvexsr1Range) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Range::max(self : Optconvexsr1Range) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Range::to_string(self : Optconvexsr1Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_slice_make(size : Int) -> Optconvexsr1Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Optconvexsr1Slice::len(self : Optconvexsr1Slice) -> Int { self.size }

pub fn Optconvexsr1Slice::get(self : Optconvexsr1Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Optconvexsr1Slice::set(self : Optconvexsr1Slice, i : Int, v : Double) -> Optconvexsr1Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Slice::sum(self : Optconvexsr1Slice) -> Double { @_common.sum(self.data) }

pub fn Optconvexsr1Slice::mean(self : Optconvexsr1Slice) -> Double { @_common.mean(self.data) }

pub fn Optconvexsr1Slice::scale(self : Optconvexsr1Slice, f : Double) -> Optconvexsr1Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Slice::add(self : Optconvexsr1Slice, other : Optconvexsr1Slice) -> Optconvexsr1Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Optconvexsr1Slice::copy(self : Optconvexsr1Slice) -> Optconvexsr1Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Slice::fill(self : Optconvexsr1Slice, v : Double) -> Optconvexsr1Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Optconvexsr1Slice::min(self : Optconvexsr1Slice) -> Double { @_common.min(self.data) }

pub fn Optconvexsr1Slice::max(self : Optconvexsr1Slice) -> Double { @_common.max(self.data) }

pub fn Optconvexsr1Slice::to_string(self : Optconvexsr1Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

