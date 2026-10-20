///===
/// extcore/geo_proj_orthographic

pub(all) struct GeoprojorthographicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_orthographic_make_point(x : Double, y : Double) -> GeoprojorthographicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_orthographic_make_point3(x : Double, y : Double, z : Double) -> GeoprojorthographicPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojorthographicPoint::x(self : GeoprojorthographicPoint) -> Double { self.x }

pub fn GeoprojorthographicPoint::y(self : GeoprojorthographicPoint) -> Double { self.y }

pub fn GeoprojorthographicPoint::z(self : GeoprojorthographicPoint) -> Double { self.z }

pub fn GeoprojorthographicPoint::label(self : GeoprojorthographicPoint) -> Int { self.label }

pub fn GeoprojorthographicPoint::dist(self : GeoprojorthographicPoint, other : GeoprojorthographicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojorthographicPoint::add(self : GeoprojorthographicPoint, other : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojorthographicPoint::sub(self : GeoprojorthographicPoint, other : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojorthographicPoint::scale(self : GeoprojorthographicPoint, s : Double) -> GeoprojorthographicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojorthographicPoint::dot(self : GeoprojorthographicPoint, other : GeoprojorthographicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojorthographicPoint::cross(self : GeoprojorthographicPoint, other : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojorthographicPoint::norm(self : GeoprojorthographicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojorthographicPoint::normalize(self : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojorthographicPoint::negate(self : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojorthographicPoint::mid(self : GeoprojorthographicPoint, other : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojorthographicPoint::lerp(self : GeoprojorthographicPoint, other : GeoprojorthographicPoint, t : Double) -> GeoprojorthographicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojorthographicPoint::to_string(self : GeoprojorthographicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojorthographicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_orthographic_make_series(vals : Array[Double], name : String) -> GeoprojorthographicSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojorthographicSeries::len(self : GeoprojorthographicSeries) -> Int { self.vals.length() }

pub fn GeoprojorthographicSeries::sum(self : GeoprojorthographicSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojorthographicSeries::mean(self : GeoprojorthographicSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojorthographicSeries::min(self : GeoprojorthographicSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojorthographicSeries::max(self : GeoprojorthographicSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojorthographicSeries::range(self : GeoprojorthographicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojorthographicSeries::variance(self : GeoprojorthographicSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojorthographicSeries::std(self : GeoprojorthographicSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojorthographicSeries::median(self : GeoprojorthographicSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojorthographicSeries::scale(self : GeoprojorthographicSeries, f : Double) -> GeoprojorthographicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojorthographicSeries::add(self : GeoprojorthographicSeries, other : GeoprojorthographicSeries) -> GeoprojorthographicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojorthographicSeries::sub(self : GeoprojorthographicSeries, other : GeoprojorthographicSeries) -> GeoprojorthographicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojorthographicSeries::normalize(self : GeoprojorthographicSeries) -> GeoprojorthographicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojorthographicSeries::cumsum(self : GeoprojorthographicSeries) -> GeoprojorthographicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojorthographicSeries::to_string(self : GeoprojorthographicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojorthographicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_orthographic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojorthographicMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_proj_orthographic_matrix_identity(n : Int) -> GeoprojorthographicMatrix {
  let m = geo_proj_orthographic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojorthographicMatrix::get(self : GeoprojorthographicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojorthographicMatrix::transpose(self : GeoprojorthographicMatrix) -> GeoprojorthographicMatrix {
  let result = geo_proj_orthographic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojorthographicMatrix::add(self : GeoprojorthographicMatrix, other : GeoprojorthographicMatrix) -> GeoprojorthographicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_orthographic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojorthographicMatrix::scale(self : GeoprojorthographicMatrix, s : Double) -> GeoprojorthographicMatrix {
  let result = geo_proj_orthographic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojorthographicMatrix::multiply(self : GeoprojorthographicMatrix, other : GeoprojorthographicMatrix) -> GeoprojorthographicMatrix {
  if self.cols != other.rows { return geo_proj_orthographic_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_orthographic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeoprojorthographicMatrix::trace(self : GeoprojorthographicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojorthographicMatrix::det(self : GeoprojorthographicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojorthographicMatrix::norm(self : GeoprojorthographicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojorthographicMatrix::to_string(self : GeoprojorthographicMatrix) -> String {
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

pub(all) struct GeoprojorthographicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_orthographic_make_vector(comps : Array[Double]) -> GeoprojorthographicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_orthographic_vector_zero(dim : Int) -> GeoprojorthographicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojorthographicVector::add(self : GeoprojorthographicVector, other : GeoprojorthographicVector) -> GeoprojorthographicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojorthographicVector::sub(self : GeoprojorthographicVector, other : GeoprojorthographicVector) -> GeoprojorthographicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojorthographicVector::scale(self : GeoprojorthographicVector, s : Double) -> GeoprojorthographicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojorthographicVector::dot(self : GeoprojorthographicVector, other : GeoprojorthographicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojorthographicVector::norm(self : GeoprojorthographicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojorthographicVector::normalize(self : GeoprojorthographicVector) -> GeoprojorthographicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojorthographicVector::dist(self : GeoprojorthographicVector, other : GeoprojorthographicVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojorthographicVector::to_string(self : GeoprojorthographicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojorthographicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_frame_make(size : Int) -> GeoprojorthographicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicFrame::len(self : GeoprojorthographicFrame) -> Int { self.size }

pub fn GeoprojorthographicFrame::get(self : GeoprojorthographicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicFrame::set(self : GeoprojorthographicFrame, i : Int, v : Double) -> GeoprojorthographicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicFrame::sum(self : GeoprojorthographicFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicFrame::mean(self : GeoprojorthographicFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicFrame::scale(self : GeoprojorthographicFrame, f : Double) -> GeoprojorthographicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicFrame::add(self : GeoprojorthographicFrame, other : GeoprojorthographicFrame) -> GeoprojorthographicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicFrame::copy(self : GeoprojorthographicFrame) -> GeoprojorthographicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicFrame::fill(self : GeoprojorthographicFrame, v : Double) -> GeoprojorthographicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicFrame::min(self : GeoprojorthographicFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicFrame::max(self : GeoprojorthographicFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicFrame::to_string(self : GeoprojorthographicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_table_make(size : Int) -> GeoprojorthographicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicTable::len(self : GeoprojorthographicTable) -> Int { self.size }

pub fn GeoprojorthographicTable::get(self : GeoprojorthographicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicTable::set(self : GeoprojorthographicTable, i : Int, v : Double) -> GeoprojorthographicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicTable::sum(self : GeoprojorthographicTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicTable::mean(self : GeoprojorthographicTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicTable::scale(self : GeoprojorthographicTable, f : Double) -> GeoprojorthographicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicTable::add(self : GeoprojorthographicTable, other : GeoprojorthographicTable) -> GeoprojorthographicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicTable::copy(self : GeoprojorthographicTable) -> GeoprojorthographicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicTable::fill(self : GeoprojorthographicTable, v : Double) -> GeoprojorthographicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicTable::min(self : GeoprojorthographicTable) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicTable::max(self : GeoprojorthographicTable) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicTable::to_string(self : GeoprojorthographicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_graphn_make(size : Int) -> GeoprojorthographicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicGraphN::len(self : GeoprojorthographicGraphN) -> Int { self.size }

pub fn GeoprojorthographicGraphN::get(self : GeoprojorthographicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicGraphN::set(self : GeoprojorthographicGraphN, i : Int, v : Double) -> GeoprojorthographicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicGraphN::sum(self : GeoprojorthographicGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicGraphN::mean(self : GeoprojorthographicGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicGraphN::scale(self : GeoprojorthographicGraphN, f : Double) -> GeoprojorthographicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicGraphN::add(self : GeoprojorthographicGraphN, other : GeoprojorthographicGraphN) -> GeoprojorthographicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicGraphN::copy(self : GeoprojorthographicGraphN) -> GeoprojorthographicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicGraphN::fill(self : GeoprojorthographicGraphN, v : Double) -> GeoprojorthographicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicGraphN::min(self : GeoprojorthographicGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicGraphN::max(self : GeoprojorthographicGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicGraphN::to_string(self : GeoprojorthographicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_node_make(size : Int) -> GeoprojorthographicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicNode::len(self : GeoprojorthographicNode) -> Int { self.size }

pub fn GeoprojorthographicNode::get(self : GeoprojorthographicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicNode::set(self : GeoprojorthographicNode, i : Int, v : Double) -> GeoprojorthographicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicNode::sum(self : GeoprojorthographicNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicNode::mean(self : GeoprojorthographicNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicNode::scale(self : GeoprojorthographicNode, f : Double) -> GeoprojorthographicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicNode::add(self : GeoprojorthographicNode, other : GeoprojorthographicNode) -> GeoprojorthographicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicNode::copy(self : GeoprojorthographicNode) -> GeoprojorthographicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicNode::fill(self : GeoprojorthographicNode, v : Double) -> GeoprojorthographicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicNode::min(self : GeoprojorthographicNode) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicNode::max(self : GeoprojorthographicNode) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicNode::to_string(self : GeoprojorthographicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_edge_make(size : Int) -> GeoprojorthographicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicEdge::len(self : GeoprojorthographicEdge) -> Int { self.size }

pub fn GeoprojorthographicEdge::get(self : GeoprojorthographicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicEdge::set(self : GeoprojorthographicEdge, i : Int, v : Double) -> GeoprojorthographicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicEdge::sum(self : GeoprojorthographicEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicEdge::mean(self : GeoprojorthographicEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicEdge::scale(self : GeoprojorthographicEdge, f : Double) -> GeoprojorthographicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicEdge::add(self : GeoprojorthographicEdge, other : GeoprojorthographicEdge) -> GeoprojorthographicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicEdge::copy(self : GeoprojorthographicEdge) -> GeoprojorthographicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicEdge::fill(self : GeoprojorthographicEdge, v : Double) -> GeoprojorthographicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicEdge::min(self : GeoprojorthographicEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicEdge::max(self : GeoprojorthographicEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicEdge::to_string(self : GeoprojorthographicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_path_make(size : Int) -> GeoprojorthographicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicPath::len(self : GeoprojorthographicPath) -> Int { self.size }

pub fn GeoprojorthographicPath::get(self : GeoprojorthographicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicPath::set(self : GeoprojorthographicPath, i : Int, v : Double) -> GeoprojorthographicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicPath::sum(self : GeoprojorthographicPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicPath::mean(self : GeoprojorthographicPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicPath::scale(self : GeoprojorthographicPath, f : Double) -> GeoprojorthographicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicPath::add(self : GeoprojorthographicPath, other : GeoprojorthographicPath) -> GeoprojorthographicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicPath::copy(self : GeoprojorthographicPath) -> GeoprojorthographicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicPath::fill(self : GeoprojorthographicPath, v : Double) -> GeoprojorthographicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicPath::min(self : GeoprojorthographicPath) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicPath::max(self : GeoprojorthographicPath) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicPath::to_string(self : GeoprojorthographicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_cluster_make(size : Int) -> GeoprojorthographicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicCluster::len(self : GeoprojorthographicCluster) -> Int { self.size }

pub fn GeoprojorthographicCluster::get(self : GeoprojorthographicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicCluster::set(self : GeoprojorthographicCluster, i : Int, v : Double) -> GeoprojorthographicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicCluster::sum(self : GeoprojorthographicCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicCluster::mean(self : GeoprojorthographicCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicCluster::scale(self : GeoprojorthographicCluster, f : Double) -> GeoprojorthographicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicCluster::add(self : GeoprojorthographicCluster, other : GeoprojorthographicCluster) -> GeoprojorthographicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicCluster::copy(self : GeoprojorthographicCluster) -> GeoprojorthographicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicCluster::fill(self : GeoprojorthographicCluster, v : Double) -> GeoprojorthographicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicCluster::min(self : GeoprojorthographicCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicCluster::max(self : GeoprojorthographicCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicCluster::to_string(self : GeoprojorthographicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_model_make(size : Int) -> GeoprojorthographicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicModel::len(self : GeoprojorthographicModel) -> Int { self.size }

pub fn GeoprojorthographicModel::get(self : GeoprojorthographicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicModel::set(self : GeoprojorthographicModel, i : Int, v : Double) -> GeoprojorthographicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicModel::sum(self : GeoprojorthographicModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicModel::mean(self : GeoprojorthographicModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicModel::scale(self : GeoprojorthographicModel, f : Double) -> GeoprojorthographicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicModel::add(self : GeoprojorthographicModel, other : GeoprojorthographicModel) -> GeoprojorthographicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicModel::copy(self : GeoprojorthographicModel) -> GeoprojorthographicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicModel::fill(self : GeoprojorthographicModel, v : Double) -> GeoprojorthographicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicModel::min(self : GeoprojorthographicModel) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicModel::max(self : GeoprojorthographicModel) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicModel::to_string(self : GeoprojorthographicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_layer_make(size : Int) -> GeoprojorthographicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicLayer::len(self : GeoprojorthographicLayer) -> Int { self.size }

pub fn GeoprojorthographicLayer::get(self : GeoprojorthographicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicLayer::set(self : GeoprojorthographicLayer, i : Int, v : Double) -> GeoprojorthographicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicLayer::sum(self : GeoprojorthographicLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicLayer::mean(self : GeoprojorthographicLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicLayer::scale(self : GeoprojorthographicLayer, f : Double) -> GeoprojorthographicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicLayer::add(self : GeoprojorthographicLayer, other : GeoprojorthographicLayer) -> GeoprojorthographicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicLayer::copy(self : GeoprojorthographicLayer) -> GeoprojorthographicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicLayer::fill(self : GeoprojorthographicLayer, v : Double) -> GeoprojorthographicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicLayer::min(self : GeoprojorthographicLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicLayer::max(self : GeoprojorthographicLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicLayer::to_string(self : GeoprojorthographicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_buffer_make(size : Int) -> GeoprojorthographicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicBuffer::len(self : GeoprojorthographicBuffer) -> Int { self.size }

pub fn GeoprojorthographicBuffer::get(self : GeoprojorthographicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicBuffer::set(self : GeoprojorthographicBuffer, i : Int, v : Double) -> GeoprojorthographicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicBuffer::sum(self : GeoprojorthographicBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicBuffer::mean(self : GeoprojorthographicBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicBuffer::scale(self : GeoprojorthographicBuffer, f : Double) -> GeoprojorthographicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicBuffer::add(self : GeoprojorthographicBuffer, other : GeoprojorthographicBuffer) -> GeoprojorthographicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicBuffer::copy(self : GeoprojorthographicBuffer) -> GeoprojorthographicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicBuffer::fill(self : GeoprojorthographicBuffer, v : Double) -> GeoprojorthographicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicBuffer::min(self : GeoprojorthographicBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicBuffer::max(self : GeoprojorthographicBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicBuffer::to_string(self : GeoprojorthographicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_cursor_make(size : Int) -> GeoprojorthographicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicCursor::len(self : GeoprojorthographicCursor) -> Int { self.size }

pub fn GeoprojorthographicCursor::get(self : GeoprojorthographicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicCursor::set(self : GeoprojorthographicCursor, i : Int, v : Double) -> GeoprojorthographicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicCursor::sum(self : GeoprojorthographicCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicCursor::mean(self : GeoprojorthographicCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicCursor::scale(self : GeoprojorthographicCursor, f : Double) -> GeoprojorthographicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicCursor::add(self : GeoprojorthographicCursor, other : GeoprojorthographicCursor) -> GeoprojorthographicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicCursor::copy(self : GeoprojorthographicCursor) -> GeoprojorthographicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicCursor::fill(self : GeoprojorthographicCursor, v : Double) -> GeoprojorthographicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicCursor::min(self : GeoprojorthographicCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicCursor::max(self : GeoprojorthographicCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicCursor::to_string(self : GeoprojorthographicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_view_make(size : Int) -> GeoprojorthographicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicView::len(self : GeoprojorthographicView) -> Int { self.size }

pub fn GeoprojorthographicView::get(self : GeoprojorthographicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicView::set(self : GeoprojorthographicView, i : Int, v : Double) -> GeoprojorthographicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicView::sum(self : GeoprojorthographicView) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicView::mean(self : GeoprojorthographicView) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicView::scale(self : GeoprojorthographicView, f : Double) -> GeoprojorthographicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicView::add(self : GeoprojorthographicView, other : GeoprojorthographicView) -> GeoprojorthographicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicView::copy(self : GeoprojorthographicView) -> GeoprojorthographicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicView::fill(self : GeoprojorthographicView, v : Double) -> GeoprojorthographicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicView::min(self : GeoprojorthographicView) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicView::max(self : GeoprojorthographicView) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicView::to_string(self : GeoprojorthographicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_range_make(size : Int) -> GeoprojorthographicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicRange::len(self : GeoprojorthographicRange) -> Int { self.size }

pub fn GeoprojorthographicRange::get(self : GeoprojorthographicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicRange::set(self : GeoprojorthographicRange, i : Int, v : Double) -> GeoprojorthographicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicRange::sum(self : GeoprojorthographicRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicRange::mean(self : GeoprojorthographicRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicRange::scale(self : GeoprojorthographicRange, f : Double) -> GeoprojorthographicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicRange::add(self : GeoprojorthographicRange, other : GeoprojorthographicRange) -> GeoprojorthographicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicRange::copy(self : GeoprojorthographicRange) -> GeoprojorthographicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicRange::fill(self : GeoprojorthographicRange, v : Double) -> GeoprojorthographicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicRange::min(self : GeoprojorthographicRange) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicRange::max(self : GeoprojorthographicRange) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicRange::to_string(self : GeoprojorthographicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_slice_make(size : Int) -> GeoprojorthographicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojorthographicSlice::len(self : GeoprojorthographicSlice) -> Int { self.size }

pub fn GeoprojorthographicSlice::get(self : GeoprojorthographicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojorthographicSlice::set(self : GeoprojorthographicSlice, i : Int, v : Double) -> GeoprojorthographicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicSlice::sum(self : GeoprojorthographicSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojorthographicSlice::mean(self : GeoprojorthographicSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojorthographicSlice::scale(self : GeoprojorthographicSlice, f : Double) -> GeoprojorthographicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicSlice::add(self : GeoprojorthographicSlice, other : GeoprojorthographicSlice) -> GeoprojorthographicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojorthographicSlice::copy(self : GeoprojorthographicSlice) -> GeoprojorthographicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicSlice::fill(self : GeoprojorthographicSlice, v : Double) -> GeoprojorthographicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojorthographicSlice::min(self : GeoprojorthographicSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojorthographicSlice::max(self : GeoprojorthographicSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojorthographicSlice::to_string(self : GeoprojorthographicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

