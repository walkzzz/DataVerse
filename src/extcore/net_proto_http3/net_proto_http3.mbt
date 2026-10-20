///===
/// extcore/net_proto_http3

pub(all) struct Netprotohttp3Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_http3_make_point(x : Double, y : Double) -> Netprotohttp3Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_http3_make_point3(x : Double, y : Double, z : Double) -> Netprotohttp3Point {
  { x, y, z, label: 0 }
}

pub fn Netprotohttp3Point::x(self : Netprotohttp3Point) -> Double { self.x }

pub fn Netprotohttp3Point::y(self : Netprotohttp3Point) -> Double { self.y }

pub fn Netprotohttp3Point::z(self : Netprotohttp3Point) -> Double { self.z }

pub fn Netprotohttp3Point::label(self : Netprotohttp3Point) -> Int { self.label }

pub fn Netprotohttp3Point::dist(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Netprotohttp3Point::add(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Netprotohttp3Point::sub(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Netprotohttp3Point::scale(self : Netprotohttp3Point, s : Double) -> Netprotohttp3Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Netprotohttp3Point::dot(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Netprotohttp3Point::cross(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Netprotohttp3Point::norm(self : Netprotohttp3Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Netprotohttp3Point::normalize(self : Netprotohttp3Point) -> Netprotohttp3Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Netprotohttp3Point::negate(self : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Netprotohttp3Point::mid(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Netprotohttp3Point::lerp(self : Netprotohttp3Point, other : Netprotohttp3Point, t : Double) -> Netprotohttp3Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Netprotohttp3Point::to_string(self : Netprotohttp3Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Netprotohttp3Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_http3_make_series(vals : Array[Double], name : String) -> Netprotohttp3Series {
  { vals, name, meta: 0 }
}

pub fn Netprotohttp3Series::len(self : Netprotohttp3Series) -> Int { self.vals.length() }

pub fn Netprotohttp3Series::sum(self : Netprotohttp3Series) -> Double { @_common.sum(self.vals) }

pub fn Netprotohttp3Series::mean(self : Netprotohttp3Series) -> Double { @_common.mean(self.vals) }

pub fn Netprotohttp3Series::min(self : Netprotohttp3Series) -> Double { @_common.min(self.vals) }

pub fn Netprotohttp3Series::max(self : Netprotohttp3Series) -> Double { @_common.max(self.vals) }

pub fn Netprotohttp3Series::range(self : Netprotohttp3Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Netprotohttp3Series::variance(self : Netprotohttp3Series) -> Double { @_common.variance(self.vals) }

pub fn Netprotohttp3Series::std(self : Netprotohttp3Series) -> Double { @_common.std(self.vals) }

pub fn Netprotohttp3Series::median(self : Netprotohttp3Series) -> Double { @_common.median(self.vals) }

pub fn Netprotohttp3Series::scale(self : Netprotohttp3Series, f : Double) -> Netprotohttp3Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Netprotohttp3Series::add(self : Netprotohttp3Series, other : Netprotohttp3Series) -> Netprotohttp3Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Netprotohttp3Series::sub(self : Netprotohttp3Series, other : Netprotohttp3Series) -> Netprotohttp3Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Netprotohttp3Series::normalize(self : Netprotohttp3Series) -> Netprotohttp3Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Netprotohttp3Series::cumsum(self : Netprotohttp3Series) -> Netprotohttp3Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Netprotohttp3Series::to_string(self : Netprotohttp3Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Netprotohttp3Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_http3_make_matrix(rows : Int, cols : Int, val : Double) -> Netprotohttp3Matrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn net_proto_http3_matrix_identity(n : Int) -> Netprotohttp3Matrix {
  let m = net_proto_http3_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Netprotohttp3Matrix::get(self : Netprotohttp3Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Netprotohttp3Matrix::transpose(self : Netprotohttp3Matrix) -> Netprotohttp3Matrix {
  let result = net_proto_http3_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Netprotohttp3Matrix::add(self : Netprotohttp3Matrix, other : Netprotohttp3Matrix) -> Netprotohttp3Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_http3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Netprotohttp3Matrix::scale(self : Netprotohttp3Matrix, s : Double) -> Netprotohttp3Matrix {
  let result = net_proto_http3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Netprotohttp3Matrix::multiply(self : Netprotohttp3Matrix, other : Netprotohttp3Matrix) -> Netprotohttp3Matrix {
  if self.cols != other.rows { return net_proto_http3_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_http3_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Netprotohttp3Matrix::trace(self : Netprotohttp3Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Netprotohttp3Matrix::det(self : Netprotohttp3Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Netprotohttp3Matrix::norm(self : Netprotohttp3Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Netprotohttp3Matrix::to_string(self : Netprotohttp3Matrix) -> String {
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

pub(all) struct Netprotohttp3Vector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_http3_make_vector(comps : Array[Double]) -> Netprotohttp3Vector {
  { comps, dim: comps.length() }
}

pub fn net_proto_http3_vector_zero(dim : Int) -> Netprotohttp3Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Netprotohttp3Vector::add(self : Netprotohttp3Vector, other : Netprotohttp3Vector) -> Netprotohttp3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Netprotohttp3Vector::sub(self : Netprotohttp3Vector, other : Netprotohttp3Vector) -> Netprotohttp3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Netprotohttp3Vector::scale(self : Netprotohttp3Vector, s : Double) -> Netprotohttp3Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Netprotohttp3Vector::dot(self : Netprotohttp3Vector, other : Netprotohttp3Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Netprotohttp3Vector::norm(self : Netprotohttp3Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Netprotohttp3Vector::normalize(self : Netprotohttp3Vector) -> Netprotohttp3Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Netprotohttp3Vector::dist(self : Netprotohttp3Vector, other : Netprotohttp3Vector) -> Double {
  self.sub(other).norm()
}

pub fn Netprotohttp3Vector::to_string(self : Netprotohttp3Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Netprotohttp3Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_frame_make(size : Int) -> Netprotohttp3Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Frame::len(self : Netprotohttp3Frame) -> Int { self.size }

pub fn Netprotohttp3Frame::get(self : Netprotohttp3Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Frame::set(self : Netprotohttp3Frame, i : Int, v : Double) -> Netprotohttp3Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Frame::sum(self : Netprotohttp3Frame) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Frame::mean(self : Netprotohttp3Frame) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Frame::scale(self : Netprotohttp3Frame, f : Double) -> Netprotohttp3Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Frame::add(self : Netprotohttp3Frame, other : Netprotohttp3Frame) -> Netprotohttp3Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Frame::copy(self : Netprotohttp3Frame) -> Netprotohttp3Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Frame::fill(self : Netprotohttp3Frame, v : Double) -> Netprotohttp3Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Frame::min(self : Netprotohttp3Frame) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Frame::max(self : Netprotohttp3Frame) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Frame::to_string(self : Netprotohttp3Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_table_make(size : Int) -> Netprotohttp3Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Table::len(self : Netprotohttp3Table) -> Int { self.size }

pub fn Netprotohttp3Table::get(self : Netprotohttp3Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Table::set(self : Netprotohttp3Table, i : Int, v : Double) -> Netprotohttp3Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Table::sum(self : Netprotohttp3Table) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Table::mean(self : Netprotohttp3Table) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Table::scale(self : Netprotohttp3Table, f : Double) -> Netprotohttp3Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Table::add(self : Netprotohttp3Table, other : Netprotohttp3Table) -> Netprotohttp3Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Table::copy(self : Netprotohttp3Table) -> Netprotohttp3Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Table::fill(self : Netprotohttp3Table, v : Double) -> Netprotohttp3Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Table::min(self : Netprotohttp3Table) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Table::max(self : Netprotohttp3Table) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Table::to_string(self : Netprotohttp3Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_graphn_make(size : Int) -> Netprotohttp3GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3GraphN::len(self : Netprotohttp3GraphN) -> Int { self.size }

pub fn Netprotohttp3GraphN::get(self : Netprotohttp3GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3GraphN::set(self : Netprotohttp3GraphN, i : Int, v : Double) -> Netprotohttp3GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3GraphN::sum(self : Netprotohttp3GraphN) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3GraphN::mean(self : Netprotohttp3GraphN) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3GraphN::scale(self : Netprotohttp3GraphN, f : Double) -> Netprotohttp3GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3GraphN::add(self : Netprotohttp3GraphN, other : Netprotohttp3GraphN) -> Netprotohttp3GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3GraphN::copy(self : Netprotohttp3GraphN) -> Netprotohttp3GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3GraphN::fill(self : Netprotohttp3GraphN, v : Double) -> Netprotohttp3GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3GraphN::min(self : Netprotohttp3GraphN) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3GraphN::max(self : Netprotohttp3GraphN) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3GraphN::to_string(self : Netprotohttp3GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_node_make(size : Int) -> Netprotohttp3Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Node::len(self : Netprotohttp3Node) -> Int { self.size }

pub fn Netprotohttp3Node::get(self : Netprotohttp3Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Node::set(self : Netprotohttp3Node, i : Int, v : Double) -> Netprotohttp3Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Node::sum(self : Netprotohttp3Node) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Node::mean(self : Netprotohttp3Node) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Node::scale(self : Netprotohttp3Node, f : Double) -> Netprotohttp3Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Node::add(self : Netprotohttp3Node, other : Netprotohttp3Node) -> Netprotohttp3Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Node::copy(self : Netprotohttp3Node) -> Netprotohttp3Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Node::fill(self : Netprotohttp3Node, v : Double) -> Netprotohttp3Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Node::min(self : Netprotohttp3Node) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Node::max(self : Netprotohttp3Node) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Node::to_string(self : Netprotohttp3Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_edge_make(size : Int) -> Netprotohttp3Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Edge::len(self : Netprotohttp3Edge) -> Int { self.size }

pub fn Netprotohttp3Edge::get(self : Netprotohttp3Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Edge::set(self : Netprotohttp3Edge, i : Int, v : Double) -> Netprotohttp3Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Edge::sum(self : Netprotohttp3Edge) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Edge::mean(self : Netprotohttp3Edge) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Edge::scale(self : Netprotohttp3Edge, f : Double) -> Netprotohttp3Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Edge::add(self : Netprotohttp3Edge, other : Netprotohttp3Edge) -> Netprotohttp3Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Edge::copy(self : Netprotohttp3Edge) -> Netprotohttp3Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Edge::fill(self : Netprotohttp3Edge, v : Double) -> Netprotohttp3Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Edge::min(self : Netprotohttp3Edge) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Edge::max(self : Netprotohttp3Edge) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Edge::to_string(self : Netprotohttp3Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_path_make(size : Int) -> Netprotohttp3Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Path::len(self : Netprotohttp3Path) -> Int { self.size }

pub fn Netprotohttp3Path::get(self : Netprotohttp3Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Path::set(self : Netprotohttp3Path, i : Int, v : Double) -> Netprotohttp3Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Path::sum(self : Netprotohttp3Path) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Path::mean(self : Netprotohttp3Path) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Path::scale(self : Netprotohttp3Path, f : Double) -> Netprotohttp3Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Path::add(self : Netprotohttp3Path, other : Netprotohttp3Path) -> Netprotohttp3Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Path::copy(self : Netprotohttp3Path) -> Netprotohttp3Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Path::fill(self : Netprotohttp3Path, v : Double) -> Netprotohttp3Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Path::min(self : Netprotohttp3Path) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Path::max(self : Netprotohttp3Path) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Path::to_string(self : Netprotohttp3Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_cluster_make(size : Int) -> Netprotohttp3Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Cluster::len(self : Netprotohttp3Cluster) -> Int { self.size }

pub fn Netprotohttp3Cluster::get(self : Netprotohttp3Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Cluster::set(self : Netprotohttp3Cluster, i : Int, v : Double) -> Netprotohttp3Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Cluster::sum(self : Netprotohttp3Cluster) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Cluster::mean(self : Netprotohttp3Cluster) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Cluster::scale(self : Netprotohttp3Cluster, f : Double) -> Netprotohttp3Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Cluster::add(self : Netprotohttp3Cluster, other : Netprotohttp3Cluster) -> Netprotohttp3Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Cluster::copy(self : Netprotohttp3Cluster) -> Netprotohttp3Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Cluster::fill(self : Netprotohttp3Cluster, v : Double) -> Netprotohttp3Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Cluster::min(self : Netprotohttp3Cluster) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Cluster::max(self : Netprotohttp3Cluster) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Cluster::to_string(self : Netprotohttp3Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_model_make(size : Int) -> Netprotohttp3Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Model::len(self : Netprotohttp3Model) -> Int { self.size }

pub fn Netprotohttp3Model::get(self : Netprotohttp3Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Model::set(self : Netprotohttp3Model, i : Int, v : Double) -> Netprotohttp3Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Model::sum(self : Netprotohttp3Model) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Model::mean(self : Netprotohttp3Model) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Model::scale(self : Netprotohttp3Model, f : Double) -> Netprotohttp3Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Model::add(self : Netprotohttp3Model, other : Netprotohttp3Model) -> Netprotohttp3Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Model::copy(self : Netprotohttp3Model) -> Netprotohttp3Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Model::fill(self : Netprotohttp3Model, v : Double) -> Netprotohttp3Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Model::min(self : Netprotohttp3Model) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Model::max(self : Netprotohttp3Model) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Model::to_string(self : Netprotohttp3Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_layer_make(size : Int) -> Netprotohttp3Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Layer::len(self : Netprotohttp3Layer) -> Int { self.size }

pub fn Netprotohttp3Layer::get(self : Netprotohttp3Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Layer::set(self : Netprotohttp3Layer, i : Int, v : Double) -> Netprotohttp3Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Layer::sum(self : Netprotohttp3Layer) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Layer::mean(self : Netprotohttp3Layer) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Layer::scale(self : Netprotohttp3Layer, f : Double) -> Netprotohttp3Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Layer::add(self : Netprotohttp3Layer, other : Netprotohttp3Layer) -> Netprotohttp3Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Layer::copy(self : Netprotohttp3Layer) -> Netprotohttp3Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Layer::fill(self : Netprotohttp3Layer, v : Double) -> Netprotohttp3Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Layer::min(self : Netprotohttp3Layer) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Layer::max(self : Netprotohttp3Layer) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Layer::to_string(self : Netprotohttp3Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_buffer_make(size : Int) -> Netprotohttp3Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Buffer::len(self : Netprotohttp3Buffer) -> Int { self.size }

pub fn Netprotohttp3Buffer::get(self : Netprotohttp3Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Buffer::set(self : Netprotohttp3Buffer, i : Int, v : Double) -> Netprotohttp3Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Buffer::sum(self : Netprotohttp3Buffer) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Buffer::mean(self : Netprotohttp3Buffer) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Buffer::scale(self : Netprotohttp3Buffer, f : Double) -> Netprotohttp3Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Buffer::add(self : Netprotohttp3Buffer, other : Netprotohttp3Buffer) -> Netprotohttp3Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Buffer::copy(self : Netprotohttp3Buffer) -> Netprotohttp3Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Buffer::fill(self : Netprotohttp3Buffer, v : Double) -> Netprotohttp3Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Buffer::min(self : Netprotohttp3Buffer) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Buffer::max(self : Netprotohttp3Buffer) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Buffer::to_string(self : Netprotohttp3Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_cursor_make(size : Int) -> Netprotohttp3Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Cursor::len(self : Netprotohttp3Cursor) -> Int { self.size }

pub fn Netprotohttp3Cursor::get(self : Netprotohttp3Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Cursor::set(self : Netprotohttp3Cursor, i : Int, v : Double) -> Netprotohttp3Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Cursor::sum(self : Netprotohttp3Cursor) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Cursor::mean(self : Netprotohttp3Cursor) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Cursor::scale(self : Netprotohttp3Cursor, f : Double) -> Netprotohttp3Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Cursor::add(self : Netprotohttp3Cursor, other : Netprotohttp3Cursor) -> Netprotohttp3Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Cursor::copy(self : Netprotohttp3Cursor) -> Netprotohttp3Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Cursor::fill(self : Netprotohttp3Cursor, v : Double) -> Netprotohttp3Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Cursor::min(self : Netprotohttp3Cursor) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Cursor::max(self : Netprotohttp3Cursor) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Cursor::to_string(self : Netprotohttp3Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_view_make(size : Int) -> Netprotohttp3View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3View::len(self : Netprotohttp3View) -> Int { self.size }

pub fn Netprotohttp3View::get(self : Netprotohttp3View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3View::set(self : Netprotohttp3View, i : Int, v : Double) -> Netprotohttp3View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3View::sum(self : Netprotohttp3View) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3View::mean(self : Netprotohttp3View) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3View::scale(self : Netprotohttp3View, f : Double) -> Netprotohttp3View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3View::add(self : Netprotohttp3View, other : Netprotohttp3View) -> Netprotohttp3View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3View::copy(self : Netprotohttp3View) -> Netprotohttp3View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3View::fill(self : Netprotohttp3View, v : Double) -> Netprotohttp3View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3View::min(self : Netprotohttp3View) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3View::max(self : Netprotohttp3View) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3View::to_string(self : Netprotohttp3View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_range_make(size : Int) -> Netprotohttp3Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Range::len(self : Netprotohttp3Range) -> Int { self.size }

pub fn Netprotohttp3Range::get(self : Netprotohttp3Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Range::set(self : Netprotohttp3Range, i : Int, v : Double) -> Netprotohttp3Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Range::sum(self : Netprotohttp3Range) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Range::mean(self : Netprotohttp3Range) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Range::scale(self : Netprotohttp3Range, f : Double) -> Netprotohttp3Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Range::add(self : Netprotohttp3Range, other : Netprotohttp3Range) -> Netprotohttp3Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Range::copy(self : Netprotohttp3Range) -> Netprotohttp3Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Range::fill(self : Netprotohttp3Range, v : Double) -> Netprotohttp3Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Range::min(self : Netprotohttp3Range) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Range::max(self : Netprotohttp3Range) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Range::to_string(self : Netprotohttp3Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_slice_make(size : Int) -> Netprotohttp3Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Netprotohttp3Slice::len(self : Netprotohttp3Slice) -> Int { self.size }

pub fn Netprotohttp3Slice::get(self : Netprotohttp3Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Netprotohttp3Slice::set(self : Netprotohttp3Slice, i : Int, v : Double) -> Netprotohttp3Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Slice::sum(self : Netprotohttp3Slice) -> Double { @_common.sum(self.data) }

pub fn Netprotohttp3Slice::mean(self : Netprotohttp3Slice) -> Double { @_common.mean(self.data) }

pub fn Netprotohttp3Slice::scale(self : Netprotohttp3Slice, f : Double) -> Netprotohttp3Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Slice::add(self : Netprotohttp3Slice, other : Netprotohttp3Slice) -> Netprotohttp3Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Netprotohttp3Slice::copy(self : Netprotohttp3Slice) -> Netprotohttp3Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Slice::fill(self : Netprotohttp3Slice, v : Double) -> Netprotohttp3Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Netprotohttp3Slice::min(self : Netprotohttp3Slice) -> Double { @_common.min(self.data) }

pub fn Netprotohttp3Slice::max(self : Netprotohttp3Slice) -> Double { @_common.max(self.data) }

pub fn Netprotohttp3Slice::to_string(self : Netprotohttp3Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

