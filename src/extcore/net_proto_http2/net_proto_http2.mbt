///===
/// extcore/net_proto_http2

pub(all) struct Netprotohttp2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_http2_make_point(x : Double, y : Double) -> Netprotohttp2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_http2_make_point3(x : Double, y : Double, z : Double) -> Netprotohttp2Point {
  { x, y, z, label: 0 }
}

pub fn Netprotohttp2Point::x(self : Netprotohttp2Point) -> Double { self.x }

pub fn Netprotohttp2Point::y(self : Netprotohttp2Point) -> Double { self.y }

pub fn Netprotohttp2Point::z(self : Netprotohttp2Point) -> Double { self.z }

pub fn Netprotohttp2Point::label(self : Netprotohttp2Point) -> Int { self.label }

pub fn Netprotohttp2Point::dist(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Netprotohttp2Point::add(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Netprotohttp2Point::sub(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Netprotohttp2Point::scale(self : Netprotohttp2Point, s : Double) -> Netprotohttp2Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Netprotohttp2Point::dot(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Netprotohttp2Point::cross(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Netprotohttp2Point::norm(self : Netprotohttp2Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Netprotohttp2Point::normalize(self : Netprotohttp2Point) -> Netprotohttp2Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Netprotohttp2Point::negate(self : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Netprotohttp2Point::mid(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Netprotohttp2Point::lerp(self : Netprotohttp2Point, other : Netprotohttp2Point, t : Double) -> Netprotohttp2Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Netprotohttp2Point::to_string(self : Netprotohttp2Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Netprotohttp2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_http2_make_series(vals : Array[Double], name : String) -> Netprotohttp2Series {
  { vals, name, meta: 0 }
}

pub fn Netprotohttp2Series::len(self : Netprotohttp2Series) -> Int { self.vals.length() }

pub fn Netprotohttp2Series::sum(self : Netprotohttp2Series) -> Double { @_common.sum(self.vals) }

pub fn Netprotohttp2Series::mean(self : Netprotohttp2Series) -> Double { @_common.mean(self.vals) }

pub fn Netprotohttp2Series::min(self : Netprotohttp2Series) -> Double { @_common.min(self.vals) }

pub fn Netprotohttp2Series::max(self : Netprotohttp2Series) -> Double { @_common.max(self.vals) }

pub fn Netprotohttp2Series::range(self : Netprotohttp2Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Netprotohttp2Series::variance(self : Netprotohttp2Series) -> Double { @_common.variance(self.vals) }

pub fn Netprotohttp2Series::std(self : Netprotohttp2Series) -> Double { @_common.std(self.vals) }

pub fn Netprotohttp2Series::median(self : Netprotohttp2Series) -> Double { @_common.median(self.vals) }

pub fn Netprotohttp2Series::scale(self : Netprotohttp2Series, f : Double) -> Netprotohttp2Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Netprotohttp2Series::add(self : Netprotohttp2Series, other : Netprotohttp2Series) -> Netprotohttp2Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Netprotohttp2Series::sub(self : Netprotohttp2Series, other : Netprotohttp2Series) -> Netprotohttp2Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Netprotohttp2Series::normalize(self : Netprotohttp2Series) -> Netprotohttp2Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Netprotohttp2Series::cumsum(self : Netprotohttp2Series) -> Netprotohttp2Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Netprotohttp2Series::to_string(self : Netprotohttp2Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Netprotohttp2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_http2_make_matrix(rows : Int, cols : Int, val : Double) -> Netprotohttp2Matrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn net_proto_http2_matrix_identity(n : Int) -> Netprotohttp2Matrix {
  let m = net_proto_http2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Netprotohttp2Matrix::get(self : Netprotohttp2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Netprotohttp2Matrix::transpose(self : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  let result = net_proto_http2_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Netprotohttp2Matrix::add(self : Netprotohttp2Matrix, other : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_http2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Netprotohttp2Matrix::scale(self : Netprotohttp2Matrix, s : Double) -> Netprotohttp2Matrix {
  let result = net_proto_http2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Netprotohttp2Matrix::multiply(self : Netprotohttp2Matrix, other : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  if self.cols != other.rows { return net_proto_http2_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_http2_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Netprotohttp2Matrix::trace(self : Netprotohttp2Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Netprotohttp2Matrix::det(self : Netprotohttp2Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Netprotohttp2Matrix::norm(self : Netprotohttp2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Netprotohttp2Matrix::to_string(self : Netprotohttp2Matrix) -> String {
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

pub(all) struct Netprotohttp2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_http2_make_vector(comps : Array[Double]) -> Netprotohttp2Vector {
  { comps, dim: comps.length() }
}

pub fn net_proto_http2_vector_zero(dim : Int) -> Netprotohttp2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Netprotohttp2Vector::add(self : Netprotohttp2Vector, other : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Netprotohttp2Vector::sub(self : Netprotohttp2Vector, other : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Netprotohttp2Vector::scale(self : Netprotohttp2Vector, s : Double) -> Netprotohttp2Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Netprotohttp2Vector::dot(self : Netprotohttp2Vector, other : Netprotohttp2Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Netprotohttp2Vector::norm(self : Netprotohttp2Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Netprotohttp2Vector::normalize(self : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Netprotohttp2Vector::dist(self : Netprotohttp2Vector, other : Netprotohttp2Vector) -> Double {
  self.sub(other).norm()
}

pub fn Netprotohttp2Vector::to_string(self : Netprotohttp2Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Netprotohttp2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_frame_make(size : Int) -> Netprotohttp2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Frame::len(self : Netprotohttp2Frame) -> Int { self.size }

pub fn Netprotohttp2Frame::get(self : Netprotohttp2Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Frame::set(self : Netprotohttp2Frame, i : Int, v : Double) -> Netprotohttp2Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Frame::sum(self : Netprotohttp2Frame) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Frame::mean(self : Netprotohttp2Frame) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Frame::scale(self : Netprotohttp2Frame, f : Double) -> Netprotohttp2Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Frame::add(self : Netprotohttp2Frame, other : Netprotohttp2Frame) -> Netprotohttp2Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Frame::copy(self : Netprotohttp2Frame) -> Netprotohttp2Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Frame::fill(self : Netprotohttp2Frame, v : Double) -> Netprotohttp2Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Frame::min(self : Netprotohttp2Frame) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Frame::max(self : Netprotohttp2Frame) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Frame::to_string(self : Netprotohttp2Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_table_make(size : Int) -> Netprotohttp2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Table::len(self : Netprotohttp2Table) -> Int { self.size }

pub fn Netprotohttp2Table::get(self : Netprotohttp2Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Table::set(self : Netprotohttp2Table, i : Int, v : Double) -> Netprotohttp2Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Table::sum(self : Netprotohttp2Table) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Table::mean(self : Netprotohttp2Table) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Table::scale(self : Netprotohttp2Table, f : Double) -> Netprotohttp2Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Table::add(self : Netprotohttp2Table, other : Netprotohttp2Table) -> Netprotohttp2Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Table::copy(self : Netprotohttp2Table) -> Netprotohttp2Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Table::fill(self : Netprotohttp2Table, v : Double) -> Netprotohttp2Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Table::min(self : Netprotohttp2Table) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Table::max(self : Netprotohttp2Table) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Table::to_string(self : Netprotohttp2Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_graphn_make(size : Int) -> Netprotohttp2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2GraphN::len(self : Netprotohttp2GraphN) -> Int { self.size }

pub fn Netprotohttp2GraphN::get(self : Netprotohttp2GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2GraphN::set(self : Netprotohttp2GraphN, i : Int, v : Double) -> Netprotohttp2GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2GraphN::sum(self : Netprotohttp2GraphN) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2GraphN::mean(self : Netprotohttp2GraphN) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2GraphN::scale(self : Netprotohttp2GraphN, f : Double) -> Netprotohttp2GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2GraphN::add(self : Netprotohttp2GraphN, other : Netprotohttp2GraphN) -> Netprotohttp2GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2GraphN::copy(self : Netprotohttp2GraphN) -> Netprotohttp2GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2GraphN::fill(self : Netprotohttp2GraphN, v : Double) -> Netprotohttp2GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2GraphN::min(self : Netprotohttp2GraphN) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2GraphN::max(self : Netprotohttp2GraphN) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2GraphN::to_string(self : Netprotohttp2GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_node_make(size : Int) -> Netprotohttp2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Node::len(self : Netprotohttp2Node) -> Int { self.size }

pub fn Netprotohttp2Node::get(self : Netprotohttp2Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Node::set(self : Netprotohttp2Node, i : Int, v : Double) -> Netprotohttp2Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Node::sum(self : Netprotohttp2Node) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Node::mean(self : Netprotohttp2Node) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Node::scale(self : Netprotohttp2Node, f : Double) -> Netprotohttp2Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Node::add(self : Netprotohttp2Node, other : Netprotohttp2Node) -> Netprotohttp2Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Node::copy(self : Netprotohttp2Node) -> Netprotohttp2Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Node::fill(self : Netprotohttp2Node, v : Double) -> Netprotohttp2Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Node::min(self : Netprotohttp2Node) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Node::max(self : Netprotohttp2Node) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Node::to_string(self : Netprotohttp2Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_edge_make(size : Int) -> Netprotohttp2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Edge::len(self : Netprotohttp2Edge) -> Int { self.size }

pub fn Netprotohttp2Edge::get(self : Netprotohttp2Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Edge::set(self : Netprotohttp2Edge, i : Int, v : Double) -> Netprotohttp2Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Edge::sum(self : Netprotohttp2Edge) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Edge::mean(self : Netprotohttp2Edge) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Edge::scale(self : Netprotohttp2Edge, f : Double) -> Netprotohttp2Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Edge::add(self : Netprotohttp2Edge, other : Netprotohttp2Edge) -> Netprotohttp2Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Edge::copy(self : Netprotohttp2Edge) -> Netprotohttp2Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Edge::fill(self : Netprotohttp2Edge, v : Double) -> Netprotohttp2Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Edge::min(self : Netprotohttp2Edge) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Edge::max(self : Netprotohttp2Edge) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Edge::to_string(self : Netprotohttp2Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_path_make(size : Int) -> Netprotohttp2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Path::len(self : Netprotohttp2Path) -> Int { self.size }

pub fn Netprotohttp2Path::get(self : Netprotohttp2Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Path::set(self : Netprotohttp2Path, i : Int, v : Double) -> Netprotohttp2Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Path::sum(self : Netprotohttp2Path) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Path::mean(self : Netprotohttp2Path) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Path::scale(self : Netprotohttp2Path, f : Double) -> Netprotohttp2Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Path::add(self : Netprotohttp2Path, other : Netprotohttp2Path) -> Netprotohttp2Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Path::copy(self : Netprotohttp2Path) -> Netprotohttp2Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Path::fill(self : Netprotohttp2Path, v : Double) -> Netprotohttp2Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Path::min(self : Netprotohttp2Path) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Path::max(self : Netprotohttp2Path) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Path::to_string(self : Netprotohttp2Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_cluster_make(size : Int) -> Netprotohttp2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Cluster::len(self : Netprotohttp2Cluster) -> Int { self.size }

pub fn Netprotohttp2Cluster::get(self : Netprotohttp2Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Cluster::set(self : Netprotohttp2Cluster, i : Int, v : Double) -> Netprotohttp2Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Cluster::sum(self : Netprotohttp2Cluster) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Cluster::mean(self : Netprotohttp2Cluster) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Cluster::scale(self : Netprotohttp2Cluster, f : Double) -> Netprotohttp2Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Cluster::add(self : Netprotohttp2Cluster, other : Netprotohttp2Cluster) -> Netprotohttp2Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Cluster::copy(self : Netprotohttp2Cluster) -> Netprotohttp2Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Cluster::fill(self : Netprotohttp2Cluster, v : Double) -> Netprotohttp2Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Cluster::min(self : Netprotohttp2Cluster) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Cluster::max(self : Netprotohttp2Cluster) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Cluster::to_string(self : Netprotohttp2Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_model_make(size : Int) -> Netprotohttp2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Model::len(self : Netprotohttp2Model) -> Int { self.size }

pub fn Netprotohttp2Model::get(self : Netprotohttp2Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Model::set(self : Netprotohttp2Model, i : Int, v : Double) -> Netprotohttp2Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Model::sum(self : Netprotohttp2Model) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Model::mean(self : Netprotohttp2Model) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Model::scale(self : Netprotohttp2Model, f : Double) -> Netprotohttp2Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Model::add(self : Netprotohttp2Model, other : Netprotohttp2Model) -> Netprotohttp2Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Model::copy(self : Netprotohttp2Model) -> Netprotohttp2Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Model::fill(self : Netprotohttp2Model, v : Double) -> Netprotohttp2Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Model::min(self : Netprotohttp2Model) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Model::max(self : Netprotohttp2Model) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Model::to_string(self : Netprotohttp2Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_layer_make(size : Int) -> Netprotohttp2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Layer::len(self : Netprotohttp2Layer) -> Int { self.size }

pub fn Netprotohttp2Layer::get(self : Netprotohttp2Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Layer::set(self : Netprotohttp2Layer, i : Int, v : Double) -> Netprotohttp2Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Layer::sum(self : Netprotohttp2Layer) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Layer::mean(self : Netprotohttp2Layer) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Layer::scale(self : Netprotohttp2Layer, f : Double) -> Netprotohttp2Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Layer::add(self : Netprotohttp2Layer, other : Netprotohttp2Layer) -> Netprotohttp2Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Layer::copy(self : Netprotohttp2Layer) -> Netprotohttp2Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Layer::fill(self : Netprotohttp2Layer, v : Double) -> Netprotohttp2Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Layer::min(self : Netprotohttp2Layer) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Layer::max(self : Netprotohttp2Layer) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Layer::to_string(self : Netprotohttp2Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_buffer_make(size : Int) -> Netprotohttp2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Buffer::len(self : Netprotohttp2Buffer) -> Int { self.size }

pub fn Netprotohttp2Buffer::get(self : Netprotohttp2Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Buffer::set(self : Netprotohttp2Buffer, i : Int, v : Double) -> Netprotohttp2Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Buffer::sum(self : Netprotohttp2Buffer) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Buffer::mean(self : Netprotohttp2Buffer) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Buffer::scale(self : Netprotohttp2Buffer, f : Double) -> Netprotohttp2Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Buffer::add(self : Netprotohttp2Buffer, other : Netprotohttp2Buffer) -> Netprotohttp2Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Buffer::copy(self : Netprotohttp2Buffer) -> Netprotohttp2Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Buffer::fill(self : Netprotohttp2Buffer, v : Double) -> Netprotohttp2Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Buffer::min(self : Netprotohttp2Buffer) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Buffer::max(self : Netprotohttp2Buffer) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Buffer::to_string(self : Netprotohttp2Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_cursor_make(size : Int) -> Netprotohttp2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Cursor::len(self : Netprotohttp2Cursor) -> Int { self.size }

pub fn Netprotohttp2Cursor::get(self : Netprotohttp2Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Cursor::set(self : Netprotohttp2Cursor, i : Int, v : Double) -> Netprotohttp2Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Cursor::sum(self : Netprotohttp2Cursor) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Cursor::mean(self : Netprotohttp2Cursor) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Cursor::scale(self : Netprotohttp2Cursor, f : Double) -> Netprotohttp2Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Cursor::add(self : Netprotohttp2Cursor, other : Netprotohttp2Cursor) -> Netprotohttp2Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Cursor::copy(self : Netprotohttp2Cursor) -> Netprotohttp2Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Cursor::fill(self : Netprotohttp2Cursor, v : Double) -> Netprotohttp2Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Cursor::min(self : Netprotohttp2Cursor) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Cursor::max(self : Netprotohttp2Cursor) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Cursor::to_string(self : Netprotohttp2Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_view_make(size : Int) -> Netprotohttp2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2View::len(self : Netprotohttp2View) -> Int { self.size }

pub fn Netprotohttp2View::get(self : Netprotohttp2View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2View::set(self : Netprotohttp2View, i : Int, v : Double) -> Netprotohttp2View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2View::sum(self : Netprotohttp2View) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2View::mean(self : Netprotohttp2View) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2View::scale(self : Netprotohttp2View, f : Double) -> Netprotohttp2View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2View::add(self : Netprotohttp2View, other : Netprotohttp2View) -> Netprotohttp2View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2View::copy(self : Netprotohttp2View) -> Netprotohttp2View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2View::fill(self : Netprotohttp2View, v : Double) -> Netprotohttp2View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2View::min(self : Netprotohttp2View) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2View::max(self : Netprotohttp2View) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2View::to_string(self : Netprotohttp2View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_range_make(size : Int) -> Netprotohttp2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Range::len(self : Netprotohttp2Range) -> Int { self.size }

pub fn Netprotohttp2Range::get(self : Netprotohttp2Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Range::set(self : Netprotohttp2Range, i : Int, v : Double) -> Netprotohttp2Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Range::sum(self : Netprotohttp2Range) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Range::mean(self : Netprotohttp2Range) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Range::scale(self : Netprotohttp2Range, f : Double) -> Netprotohttp2Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Range::add(self : Netprotohttp2Range, other : Netprotohttp2Range) -> Netprotohttp2Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Range::copy(self : Netprotohttp2Range) -> Netprotohttp2Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Range::fill(self : Netprotohttp2Range, v : Double) -> Netprotohttp2Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Range::min(self : Netprotohttp2Range) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Range::max(self : Netprotohttp2Range) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Range::to_string(self : Netprotohttp2Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_slice_make(size : Int) -> Netprotohttp2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp2Slice::len(self : Netprotohttp2Slice) -> Int { self.size }

pub fn Netprotohttp2Slice::get(self : Netprotohttp2Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp2Slice::set(self : Netprotohttp2Slice, i : Int, v : Double) -> Netprotohttp2Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Slice::sum(self : Netprotohttp2Slice) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp2Slice::mean(self : Netprotohttp2Slice) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp2Slice::scale(self : Netprotohttp2Slice, f : Double) -> Netprotohttp2Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Slice::add(self : Netprotohttp2Slice, other : Netprotohttp2Slice) -> Netprotohttp2Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp2Slice::copy(self : Netprotohttp2Slice) -> Netprotohttp2Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Slice::fill(self : Netprotohttp2Slice, v : Double) -> Netprotohttp2Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp2Slice::min(self : Netprotohttp2Slice) -> Double { @_common.min(self.data) }

pub fn Netprotohttp2Slice::max(self : Netprotohttp2Slice) -> Double { @_common.max(self.data) }

pub fn Netprotohttp2Slice::to_string(self : Netprotohttp2Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

