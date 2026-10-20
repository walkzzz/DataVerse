///===
/// extcore/geo_proj_utm

pub(all) struct GeoprojutmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_utm_make_point(x : Double, y : Double) -> GeoprojutmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_utm_make_point3(x : Double, y : Double, z : Double) -> GeoprojutmPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojutmPoint::x(self : GeoprojutmPoint) -> Double { self.x }

pub fn GeoprojutmPoint::y(self : GeoprojutmPoint) -> Double { self.y }

pub fn GeoprojutmPoint::z(self : GeoprojutmPoint) -> Double { self.z }

pub fn GeoprojutmPoint::label(self : GeoprojutmPoint) -> Int { self.label }

pub fn GeoprojutmPoint::dist(self : GeoprojutmPoint, other : GeoprojutmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojutmPoint::add(self : GeoprojutmPoint, other : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojutmPoint::sub(self : GeoprojutmPoint, other : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojutmPoint::scale(self : GeoprojutmPoint, s : Double) -> GeoprojutmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojutmPoint::dot(self : GeoprojutmPoint, other : GeoprojutmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojutmPoint::cross(self : GeoprojutmPoint, other : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojutmPoint::norm(self : GeoprojutmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojutmPoint::normalize(self : GeoprojutmPoint) -> GeoprojutmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojutmPoint::negate(self : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojutmPoint::mid(self : GeoprojutmPoint, other : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojutmPoint::lerp(self : GeoprojutmPoint, other : GeoprojutmPoint, t : Double) -> GeoprojutmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojutmPoint::to_string(self : GeoprojutmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojutmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_utm_make_series(vals : Array[Double], name : String) -> GeoprojutmSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojutmSeries::len(self : GeoprojutmSeries) -> Int { self.vals.length() }

pub fn GeoprojutmSeries::sum(self : GeoprojutmSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojutmSeries::mean(self : GeoprojutmSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojutmSeries::min(self : GeoprojutmSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojutmSeries::max(self : GeoprojutmSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojutmSeries::range(self : GeoprojutmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojutmSeries::variance(self : GeoprojutmSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojutmSeries::std(self : GeoprojutmSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojutmSeries::median(self : GeoprojutmSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojutmSeries::scale(self : GeoprojutmSeries, f : Double) -> GeoprojutmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojutmSeries::add(self : GeoprojutmSeries, other : GeoprojutmSeries) -> GeoprojutmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojutmSeries::sub(self : GeoprojutmSeries, other : GeoprojutmSeries) -> GeoprojutmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojutmSeries::normalize(self : GeoprojutmSeries) -> GeoprojutmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojutmSeries::cumsum(self : GeoprojutmSeries) -> GeoprojutmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojutmSeries::to_string(self : GeoprojutmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojutmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_utm_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojutmMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_proj_utm_matrix_identity(n : Int) -> GeoprojutmMatrix {
  let m = geo_proj_utm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojutmMatrix::get(self : GeoprojutmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojutmMatrix::transpose(self : GeoprojutmMatrix) -> GeoprojutmMatrix {
  let result = geo_proj_utm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojutmMatrix::add(self : GeoprojutmMatrix, other : GeoprojutmMatrix) -> GeoprojutmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_utm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojutmMatrix::scale(self : GeoprojutmMatrix, s : Double) -> GeoprojutmMatrix {
  let result = geo_proj_utm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojutmMatrix::multiply(self : GeoprojutmMatrix, other : GeoprojutmMatrix) -> GeoprojutmMatrix {
  if self.cols != other.rows { return geo_proj_utm_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_utm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeoprojutmMatrix::trace(self : GeoprojutmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojutmMatrix::det(self : GeoprojutmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojutmMatrix::norm(self : GeoprojutmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojutmMatrix::to_string(self : GeoprojutmMatrix) -> String {
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

pub(all) struct GeoprojutmVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_utm_make_vector(comps : Array[Double]) -> GeoprojutmVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_utm_vector_zero(dim : Int) -> GeoprojutmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojutmVector::add(self : GeoprojutmVector, other : GeoprojutmVector) -> GeoprojutmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojutmVector::sub(self : GeoprojutmVector, other : GeoprojutmVector) -> GeoprojutmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojutmVector::scale(self : GeoprojutmVector, s : Double) -> GeoprojutmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojutmVector::dot(self : GeoprojutmVector, other : GeoprojutmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojutmVector::norm(self : GeoprojutmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojutmVector::normalize(self : GeoprojutmVector) -> GeoprojutmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojutmVector::dist(self : GeoprojutmVector, other : GeoprojutmVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojutmVector::to_string(self : GeoprojutmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojutmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_frame_make(size : Int) -> GeoprojutmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmFrame::len(self : GeoprojutmFrame) -> Int { self.size }

pub fn GeoprojutmFrame::get(self : GeoprojutmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmFrame::set(self : GeoprojutmFrame, i : Int, v : Double) -> GeoprojutmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmFrame::sum(self : GeoprojutmFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmFrame::mean(self : GeoprojutmFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmFrame::scale(self : GeoprojutmFrame, f : Double) -> GeoprojutmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmFrame::add(self : GeoprojutmFrame, other : GeoprojutmFrame) -> GeoprojutmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmFrame::copy(self : GeoprojutmFrame) -> GeoprojutmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmFrame::fill(self : GeoprojutmFrame, v : Double) -> GeoprojutmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmFrame::min(self : GeoprojutmFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojutmFrame::max(self : GeoprojutmFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojutmFrame::to_string(self : GeoprojutmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_table_make(size : Int) -> GeoprojutmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmTable::len(self : GeoprojutmTable) -> Int { self.size }

pub fn GeoprojutmTable::get(self : GeoprojutmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmTable::set(self : GeoprojutmTable, i : Int, v : Double) -> GeoprojutmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmTable::sum(self : GeoprojutmTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmTable::mean(self : GeoprojutmTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmTable::scale(self : GeoprojutmTable, f : Double) -> GeoprojutmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmTable::add(self : GeoprojutmTable, other : GeoprojutmTable) -> GeoprojutmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmTable::copy(self : GeoprojutmTable) -> GeoprojutmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmTable::fill(self : GeoprojutmTable, v : Double) -> GeoprojutmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmTable::min(self : GeoprojutmTable) -> Double { @_common.min(self.data) }

pub fn GeoprojutmTable::max(self : GeoprojutmTable) -> Double { @_common.max(self.data) }

pub fn GeoprojutmTable::to_string(self : GeoprojutmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_graphn_make(size : Int) -> GeoprojutmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmGraphN::len(self : GeoprojutmGraphN) -> Int { self.size }

pub fn GeoprojutmGraphN::get(self : GeoprojutmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmGraphN::set(self : GeoprojutmGraphN, i : Int, v : Double) -> GeoprojutmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmGraphN::sum(self : GeoprojutmGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmGraphN::mean(self : GeoprojutmGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmGraphN::scale(self : GeoprojutmGraphN, f : Double) -> GeoprojutmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmGraphN::add(self : GeoprojutmGraphN, other : GeoprojutmGraphN) -> GeoprojutmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmGraphN::copy(self : GeoprojutmGraphN) -> GeoprojutmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmGraphN::fill(self : GeoprojutmGraphN, v : Double) -> GeoprojutmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmGraphN::min(self : GeoprojutmGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojutmGraphN::max(self : GeoprojutmGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojutmGraphN::to_string(self : GeoprojutmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_node_make(size : Int) -> GeoprojutmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmNode::len(self : GeoprojutmNode) -> Int { self.size }

pub fn GeoprojutmNode::get(self : GeoprojutmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmNode::set(self : GeoprojutmNode, i : Int, v : Double) -> GeoprojutmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmNode::sum(self : GeoprojutmNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmNode::mean(self : GeoprojutmNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmNode::scale(self : GeoprojutmNode, f : Double) -> GeoprojutmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmNode::add(self : GeoprojutmNode, other : GeoprojutmNode) -> GeoprojutmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmNode::copy(self : GeoprojutmNode) -> GeoprojutmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmNode::fill(self : GeoprojutmNode, v : Double) -> GeoprojutmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmNode::min(self : GeoprojutmNode) -> Double { @_common.min(self.data) }

pub fn GeoprojutmNode::max(self : GeoprojutmNode) -> Double { @_common.max(self.data) }

pub fn GeoprojutmNode::to_string(self : GeoprojutmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_edge_make(size : Int) -> GeoprojutmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmEdge::len(self : GeoprojutmEdge) -> Int { self.size }

pub fn GeoprojutmEdge::get(self : GeoprojutmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmEdge::set(self : GeoprojutmEdge, i : Int, v : Double) -> GeoprojutmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmEdge::sum(self : GeoprojutmEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmEdge::mean(self : GeoprojutmEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmEdge::scale(self : GeoprojutmEdge, f : Double) -> GeoprojutmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmEdge::add(self : GeoprojutmEdge, other : GeoprojutmEdge) -> GeoprojutmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmEdge::copy(self : GeoprojutmEdge) -> GeoprojutmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmEdge::fill(self : GeoprojutmEdge, v : Double) -> GeoprojutmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmEdge::min(self : GeoprojutmEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojutmEdge::max(self : GeoprojutmEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojutmEdge::to_string(self : GeoprojutmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_path_make(size : Int) -> GeoprojutmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmPath::len(self : GeoprojutmPath) -> Int { self.size }

pub fn GeoprojutmPath::get(self : GeoprojutmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmPath::set(self : GeoprojutmPath, i : Int, v : Double) -> GeoprojutmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmPath::sum(self : GeoprojutmPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmPath::mean(self : GeoprojutmPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmPath::scale(self : GeoprojutmPath, f : Double) -> GeoprojutmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmPath::add(self : GeoprojutmPath, other : GeoprojutmPath) -> GeoprojutmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmPath::copy(self : GeoprojutmPath) -> GeoprojutmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmPath::fill(self : GeoprojutmPath, v : Double) -> GeoprojutmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmPath::min(self : GeoprojutmPath) -> Double { @_common.min(self.data) }

pub fn GeoprojutmPath::max(self : GeoprojutmPath) -> Double { @_common.max(self.data) }

pub fn GeoprojutmPath::to_string(self : GeoprojutmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_cluster_make(size : Int) -> GeoprojutmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmCluster::len(self : GeoprojutmCluster) -> Int { self.size }

pub fn GeoprojutmCluster::get(self : GeoprojutmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmCluster::set(self : GeoprojutmCluster, i : Int, v : Double) -> GeoprojutmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmCluster::sum(self : GeoprojutmCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmCluster::mean(self : GeoprojutmCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmCluster::scale(self : GeoprojutmCluster, f : Double) -> GeoprojutmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmCluster::add(self : GeoprojutmCluster, other : GeoprojutmCluster) -> GeoprojutmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmCluster::copy(self : GeoprojutmCluster) -> GeoprojutmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmCluster::fill(self : GeoprojutmCluster, v : Double) -> GeoprojutmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmCluster::min(self : GeoprojutmCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojutmCluster::max(self : GeoprojutmCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojutmCluster::to_string(self : GeoprojutmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_model_make(size : Int) -> GeoprojutmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmModel::len(self : GeoprojutmModel) -> Int { self.size }

pub fn GeoprojutmModel::get(self : GeoprojutmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmModel::set(self : GeoprojutmModel, i : Int, v : Double) -> GeoprojutmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmModel::sum(self : GeoprojutmModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmModel::mean(self : GeoprojutmModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmModel::scale(self : GeoprojutmModel, f : Double) -> GeoprojutmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmModel::add(self : GeoprojutmModel, other : GeoprojutmModel) -> GeoprojutmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmModel::copy(self : GeoprojutmModel) -> GeoprojutmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmModel::fill(self : GeoprojutmModel, v : Double) -> GeoprojutmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmModel::min(self : GeoprojutmModel) -> Double { @_common.min(self.data) }

pub fn GeoprojutmModel::max(self : GeoprojutmModel) -> Double { @_common.max(self.data) }

pub fn GeoprojutmModel::to_string(self : GeoprojutmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_layer_make(size : Int) -> GeoprojutmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmLayer::len(self : GeoprojutmLayer) -> Int { self.size }

pub fn GeoprojutmLayer::get(self : GeoprojutmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmLayer::set(self : GeoprojutmLayer, i : Int, v : Double) -> GeoprojutmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmLayer::sum(self : GeoprojutmLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmLayer::mean(self : GeoprojutmLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmLayer::scale(self : GeoprojutmLayer, f : Double) -> GeoprojutmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmLayer::add(self : GeoprojutmLayer, other : GeoprojutmLayer) -> GeoprojutmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmLayer::copy(self : GeoprojutmLayer) -> GeoprojutmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmLayer::fill(self : GeoprojutmLayer, v : Double) -> GeoprojutmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmLayer::min(self : GeoprojutmLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojutmLayer::max(self : GeoprojutmLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojutmLayer::to_string(self : GeoprojutmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_buffer_make(size : Int) -> GeoprojutmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmBuffer::len(self : GeoprojutmBuffer) -> Int { self.size }

pub fn GeoprojutmBuffer::get(self : GeoprojutmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmBuffer::set(self : GeoprojutmBuffer, i : Int, v : Double) -> GeoprojutmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmBuffer::sum(self : GeoprojutmBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmBuffer::mean(self : GeoprojutmBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmBuffer::scale(self : GeoprojutmBuffer, f : Double) -> GeoprojutmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmBuffer::add(self : GeoprojutmBuffer, other : GeoprojutmBuffer) -> GeoprojutmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmBuffer::copy(self : GeoprojutmBuffer) -> GeoprojutmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmBuffer::fill(self : GeoprojutmBuffer, v : Double) -> GeoprojutmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmBuffer::min(self : GeoprojutmBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojutmBuffer::max(self : GeoprojutmBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojutmBuffer::to_string(self : GeoprojutmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_cursor_make(size : Int) -> GeoprojutmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmCursor::len(self : GeoprojutmCursor) -> Int { self.size }

pub fn GeoprojutmCursor::get(self : GeoprojutmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmCursor::set(self : GeoprojutmCursor, i : Int, v : Double) -> GeoprojutmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmCursor::sum(self : GeoprojutmCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmCursor::mean(self : GeoprojutmCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmCursor::scale(self : GeoprojutmCursor, f : Double) -> GeoprojutmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmCursor::add(self : GeoprojutmCursor, other : GeoprojutmCursor) -> GeoprojutmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmCursor::copy(self : GeoprojutmCursor) -> GeoprojutmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmCursor::fill(self : GeoprojutmCursor, v : Double) -> GeoprojutmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmCursor::min(self : GeoprojutmCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojutmCursor::max(self : GeoprojutmCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojutmCursor::to_string(self : GeoprojutmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_view_make(size : Int) -> GeoprojutmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmView::len(self : GeoprojutmView) -> Int { self.size }

pub fn GeoprojutmView::get(self : GeoprojutmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmView::set(self : GeoprojutmView, i : Int, v : Double) -> GeoprojutmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmView::sum(self : GeoprojutmView) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmView::mean(self : GeoprojutmView) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmView::scale(self : GeoprojutmView, f : Double) -> GeoprojutmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmView::add(self : GeoprojutmView, other : GeoprojutmView) -> GeoprojutmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmView::copy(self : GeoprojutmView) -> GeoprojutmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmView::fill(self : GeoprojutmView, v : Double) -> GeoprojutmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmView::min(self : GeoprojutmView) -> Double { @_common.min(self.data) }

pub fn GeoprojutmView::max(self : GeoprojutmView) -> Double { @_common.max(self.data) }

pub fn GeoprojutmView::to_string(self : GeoprojutmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_range_make(size : Int) -> GeoprojutmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmRange::len(self : GeoprojutmRange) -> Int { self.size }

pub fn GeoprojutmRange::get(self : GeoprojutmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmRange::set(self : GeoprojutmRange, i : Int, v : Double) -> GeoprojutmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmRange::sum(self : GeoprojutmRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmRange::mean(self : GeoprojutmRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmRange::scale(self : GeoprojutmRange, f : Double) -> GeoprojutmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmRange::add(self : GeoprojutmRange, other : GeoprojutmRange) -> GeoprojutmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmRange::copy(self : GeoprojutmRange) -> GeoprojutmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmRange::fill(self : GeoprojutmRange, v : Double) -> GeoprojutmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmRange::min(self : GeoprojutmRange) -> Double { @_common.min(self.data) }

pub fn GeoprojutmRange::max(self : GeoprojutmRange) -> Double { @_common.max(self.data) }

pub fn GeoprojutmRange::to_string(self : GeoprojutmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojutmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_slice_make(size : Int) -> GeoprojutmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojutmSlice::len(self : GeoprojutmSlice) -> Int { self.size }

pub fn GeoprojutmSlice::get(self : GeoprojutmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojutmSlice::set(self : GeoprojutmSlice, i : Int, v : Double) -> GeoprojutmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojutmSlice::sum(self : GeoprojutmSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojutmSlice::mean(self : GeoprojutmSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojutmSlice::scale(self : GeoprojutmSlice, f : Double) -> GeoprojutmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojutmSlice::add(self : GeoprojutmSlice, other : GeoprojutmSlice) -> GeoprojutmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojutmSlice::copy(self : GeoprojutmSlice) -> GeoprojutmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojutmSlice::fill(self : GeoprojutmSlice, v : Double) -> GeoprojutmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojutmSlice::min(self : GeoprojutmSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojutmSlice::max(self : GeoprojutmSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojutmSlice::to_string(self : GeoprojutmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

