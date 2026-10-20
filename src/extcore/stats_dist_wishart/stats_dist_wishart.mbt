///===
/// extcore/stats_dist_wishart

pub(all) struct StatsdistwishartPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_wishart_make_point(x : Double, y : Double) -> StatsdistwishartPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_wishart_make_point3(x : Double, y : Double, z : Double) -> StatsdistwishartPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistwishartPoint::x(self : StatsdistwishartPoint) -> Double { self.x }

pub fn StatsdistwishartPoint::y(self : StatsdistwishartPoint) -> Double { self.y }

pub fn StatsdistwishartPoint::z(self : StatsdistwishartPoint) -> Double { self.z }

pub fn StatsdistwishartPoint::label(self : StatsdistwishartPoint) -> Int { self.label }

pub fn StatsdistwishartPoint::dist(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistwishartPoint::add(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistwishartPoint::sub(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistwishartPoint::scale(self : StatsdistwishartPoint, s : Double) -> StatsdistwishartPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistwishartPoint::dot(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistwishartPoint::cross(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistwishartPoint::norm(self : StatsdistwishartPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistwishartPoint::normalize(self : StatsdistwishartPoint) -> StatsdistwishartPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistwishartPoint::negate(self : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistwishartPoint::mid(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistwishartPoint::lerp(self : StatsdistwishartPoint, other : StatsdistwishartPoint, t : Double) -> StatsdistwishartPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistwishartPoint::to_string(self : StatsdistwishartPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistwishartSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_wishart_make_series(vals : Array[Double], name : String) -> StatsdistwishartSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistwishartSeries::len(self : StatsdistwishartSeries) -> Int { self.vals.length() }

pub fn StatsdistwishartSeries::sum(self : StatsdistwishartSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistwishartSeries::mean(self : StatsdistwishartSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistwishartSeries::min(self : StatsdistwishartSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistwishartSeries::max(self : StatsdistwishartSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistwishartSeries::range(self : StatsdistwishartSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistwishartSeries::variance(self : StatsdistwishartSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistwishartSeries::std(self : StatsdistwishartSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistwishartSeries::median(self : StatsdistwishartSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistwishartSeries::scale(self : StatsdistwishartSeries, f : Double) -> StatsdistwishartSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistwishartSeries::add(self : StatsdistwishartSeries, other : StatsdistwishartSeries) -> StatsdistwishartSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistwishartSeries::sub(self : StatsdistwishartSeries, other : StatsdistwishartSeries) -> StatsdistwishartSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistwishartSeries::normalize(self : StatsdistwishartSeries) -> StatsdistwishartSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistwishartSeries::cumsum(self : StatsdistwishartSeries) -> StatsdistwishartSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistwishartSeries::to_string(self : StatsdistwishartSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistwishartMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_wishart_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistwishartMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_wishart_matrix_identity(n : Int) -> StatsdistwishartMatrix {
  let m = stats_dist_wishart_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistwishartMatrix::get(self : StatsdistwishartMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistwishartMatrix::transpose(self : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  let result = stats_dist_wishart_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistwishartMatrix::add(self : StatsdistwishartMatrix, other : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_wishart_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistwishartMatrix::scale(self : StatsdistwishartMatrix, s : Double) -> StatsdistwishartMatrix {
  let result = stats_dist_wishart_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistwishartMatrix::multiply(self : StatsdistwishartMatrix, other : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  if self.cols != other.rows { return stats_dist_wishart_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_wishart_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistwishartMatrix::trace(self : StatsdistwishartMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistwishartMatrix::det(self : StatsdistwishartMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistwishartMatrix::norm(self : StatsdistwishartMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistwishartMatrix::to_string(self : StatsdistwishartMatrix) -> String {
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

pub(all) struct StatsdistwishartVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_wishart_make_vector(comps : Array[Double]) -> StatsdistwishartVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_wishart_vector_zero(dim : Int) -> StatsdistwishartVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistwishartVector::add(self : StatsdistwishartVector, other : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistwishartVector::sub(self : StatsdistwishartVector, other : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistwishartVector::scale(self : StatsdistwishartVector, s : Double) -> StatsdistwishartVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistwishartVector::dot(self : StatsdistwishartVector, other : StatsdistwishartVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistwishartVector::norm(self : StatsdistwishartVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistwishartVector::normalize(self : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistwishartVector::dist(self : StatsdistwishartVector, other : StatsdistwishartVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistwishartVector::to_string(self : StatsdistwishartVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistwishartFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_frame_make(size : Int) -> StatsdistwishartFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartFrame::len(self : StatsdistwishartFrame) -> Int { self.size }

pub fn StatsdistwishartFrame::get(self : StatsdistwishartFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartFrame::set(self : StatsdistwishartFrame, i : Int, v : Double) -> StatsdistwishartFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartFrame::sum(self : StatsdistwishartFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartFrame::mean(self : StatsdistwishartFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartFrame::scale(self : StatsdistwishartFrame, f : Double) -> StatsdistwishartFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartFrame::add(self : StatsdistwishartFrame, other : StatsdistwishartFrame) -> StatsdistwishartFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartFrame::copy(self : StatsdistwishartFrame) -> StatsdistwishartFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartFrame::fill(self : StatsdistwishartFrame, v : Double) -> StatsdistwishartFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartFrame::min(self : StatsdistwishartFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartFrame::max(self : StatsdistwishartFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartFrame::to_string(self : StatsdistwishartFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_table_make(size : Int) -> StatsdistwishartTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartTable::len(self : StatsdistwishartTable) -> Int { self.size }

pub fn StatsdistwishartTable::get(self : StatsdistwishartTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartTable::set(self : StatsdistwishartTable, i : Int, v : Double) -> StatsdistwishartTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartTable::sum(self : StatsdistwishartTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartTable::mean(self : StatsdistwishartTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartTable::scale(self : StatsdistwishartTable, f : Double) -> StatsdistwishartTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartTable::add(self : StatsdistwishartTable, other : StatsdistwishartTable) -> StatsdistwishartTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartTable::copy(self : StatsdistwishartTable) -> StatsdistwishartTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartTable::fill(self : StatsdistwishartTable, v : Double) -> StatsdistwishartTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartTable::min(self : StatsdistwishartTable) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartTable::max(self : StatsdistwishartTable) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartTable::to_string(self : StatsdistwishartTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_graphn_make(size : Int) -> StatsdistwishartGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartGraphN::len(self : StatsdistwishartGraphN) -> Int { self.size }

pub fn StatsdistwishartGraphN::get(self : StatsdistwishartGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartGraphN::set(self : StatsdistwishartGraphN, i : Int, v : Double) -> StatsdistwishartGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartGraphN::sum(self : StatsdistwishartGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartGraphN::mean(self : StatsdistwishartGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartGraphN::scale(self : StatsdistwishartGraphN, f : Double) -> StatsdistwishartGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartGraphN::add(self : StatsdistwishartGraphN, other : StatsdistwishartGraphN) -> StatsdistwishartGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartGraphN::copy(self : StatsdistwishartGraphN) -> StatsdistwishartGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartGraphN::fill(self : StatsdistwishartGraphN, v : Double) -> StatsdistwishartGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartGraphN::min(self : StatsdistwishartGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartGraphN::max(self : StatsdistwishartGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartGraphN::to_string(self : StatsdistwishartGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_node_make(size : Int) -> StatsdistwishartNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartNode::len(self : StatsdistwishartNode) -> Int { self.size }

pub fn StatsdistwishartNode::get(self : StatsdistwishartNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartNode::set(self : StatsdistwishartNode, i : Int, v : Double) -> StatsdistwishartNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartNode::sum(self : StatsdistwishartNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartNode::mean(self : StatsdistwishartNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartNode::scale(self : StatsdistwishartNode, f : Double) -> StatsdistwishartNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartNode::add(self : StatsdistwishartNode, other : StatsdistwishartNode) -> StatsdistwishartNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartNode::copy(self : StatsdistwishartNode) -> StatsdistwishartNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartNode::fill(self : StatsdistwishartNode, v : Double) -> StatsdistwishartNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartNode::min(self : StatsdistwishartNode) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartNode::max(self : StatsdistwishartNode) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartNode::to_string(self : StatsdistwishartNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_edge_make(size : Int) -> StatsdistwishartEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartEdge::len(self : StatsdistwishartEdge) -> Int { self.size }

pub fn StatsdistwishartEdge::get(self : StatsdistwishartEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartEdge::set(self : StatsdistwishartEdge, i : Int, v : Double) -> StatsdistwishartEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartEdge::sum(self : StatsdistwishartEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartEdge::mean(self : StatsdistwishartEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartEdge::scale(self : StatsdistwishartEdge, f : Double) -> StatsdistwishartEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartEdge::add(self : StatsdistwishartEdge, other : StatsdistwishartEdge) -> StatsdistwishartEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartEdge::copy(self : StatsdistwishartEdge) -> StatsdistwishartEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartEdge::fill(self : StatsdistwishartEdge, v : Double) -> StatsdistwishartEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartEdge::min(self : StatsdistwishartEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartEdge::max(self : StatsdistwishartEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartEdge::to_string(self : StatsdistwishartEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_path_make(size : Int) -> StatsdistwishartPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartPath::len(self : StatsdistwishartPath) -> Int { self.size }

pub fn StatsdistwishartPath::get(self : StatsdistwishartPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartPath::set(self : StatsdistwishartPath, i : Int, v : Double) -> StatsdistwishartPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartPath::sum(self : StatsdistwishartPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartPath::mean(self : StatsdistwishartPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartPath::scale(self : StatsdistwishartPath, f : Double) -> StatsdistwishartPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartPath::add(self : StatsdistwishartPath, other : StatsdistwishartPath) -> StatsdistwishartPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartPath::copy(self : StatsdistwishartPath) -> StatsdistwishartPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartPath::fill(self : StatsdistwishartPath, v : Double) -> StatsdistwishartPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartPath::min(self : StatsdistwishartPath) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartPath::max(self : StatsdistwishartPath) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartPath::to_string(self : StatsdistwishartPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_cluster_make(size : Int) -> StatsdistwishartCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartCluster::len(self : StatsdistwishartCluster) -> Int { self.size }

pub fn StatsdistwishartCluster::get(self : StatsdistwishartCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartCluster::set(self : StatsdistwishartCluster, i : Int, v : Double) -> StatsdistwishartCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartCluster::sum(self : StatsdistwishartCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartCluster::mean(self : StatsdistwishartCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartCluster::scale(self : StatsdistwishartCluster, f : Double) -> StatsdistwishartCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartCluster::add(self : StatsdistwishartCluster, other : StatsdistwishartCluster) -> StatsdistwishartCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartCluster::copy(self : StatsdistwishartCluster) -> StatsdistwishartCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartCluster::fill(self : StatsdistwishartCluster, v : Double) -> StatsdistwishartCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartCluster::min(self : StatsdistwishartCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartCluster::max(self : StatsdistwishartCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartCluster::to_string(self : StatsdistwishartCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_model_make(size : Int) -> StatsdistwishartModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartModel::len(self : StatsdistwishartModel) -> Int { self.size }

pub fn StatsdistwishartModel::get(self : StatsdistwishartModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartModel::set(self : StatsdistwishartModel, i : Int, v : Double) -> StatsdistwishartModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartModel::sum(self : StatsdistwishartModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartModel::mean(self : StatsdistwishartModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartModel::scale(self : StatsdistwishartModel, f : Double) -> StatsdistwishartModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartModel::add(self : StatsdistwishartModel, other : StatsdistwishartModel) -> StatsdistwishartModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartModel::copy(self : StatsdistwishartModel) -> StatsdistwishartModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartModel::fill(self : StatsdistwishartModel, v : Double) -> StatsdistwishartModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartModel::min(self : StatsdistwishartModel) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartModel::max(self : StatsdistwishartModel) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartModel::to_string(self : StatsdistwishartModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_layer_make(size : Int) -> StatsdistwishartLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartLayer::len(self : StatsdistwishartLayer) -> Int { self.size }

pub fn StatsdistwishartLayer::get(self : StatsdistwishartLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartLayer::set(self : StatsdistwishartLayer, i : Int, v : Double) -> StatsdistwishartLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartLayer::sum(self : StatsdistwishartLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartLayer::mean(self : StatsdistwishartLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartLayer::scale(self : StatsdistwishartLayer, f : Double) -> StatsdistwishartLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartLayer::add(self : StatsdistwishartLayer, other : StatsdistwishartLayer) -> StatsdistwishartLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartLayer::copy(self : StatsdistwishartLayer) -> StatsdistwishartLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartLayer::fill(self : StatsdistwishartLayer, v : Double) -> StatsdistwishartLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartLayer::min(self : StatsdistwishartLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartLayer::max(self : StatsdistwishartLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartLayer::to_string(self : StatsdistwishartLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_buffer_make(size : Int) -> StatsdistwishartBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartBuffer::len(self : StatsdistwishartBuffer) -> Int { self.size }

pub fn StatsdistwishartBuffer::get(self : StatsdistwishartBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartBuffer::set(self : StatsdistwishartBuffer, i : Int, v : Double) -> StatsdistwishartBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartBuffer::sum(self : StatsdistwishartBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartBuffer::mean(self : StatsdistwishartBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartBuffer::scale(self : StatsdistwishartBuffer, f : Double) -> StatsdistwishartBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartBuffer::add(self : StatsdistwishartBuffer, other : StatsdistwishartBuffer) -> StatsdistwishartBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartBuffer::copy(self : StatsdistwishartBuffer) -> StatsdistwishartBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartBuffer::fill(self : StatsdistwishartBuffer, v : Double) -> StatsdistwishartBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartBuffer::min(self : StatsdistwishartBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartBuffer::max(self : StatsdistwishartBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartBuffer::to_string(self : StatsdistwishartBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_cursor_make(size : Int) -> StatsdistwishartCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartCursor::len(self : StatsdistwishartCursor) -> Int { self.size }

pub fn StatsdistwishartCursor::get(self : StatsdistwishartCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartCursor::set(self : StatsdistwishartCursor, i : Int, v : Double) -> StatsdistwishartCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartCursor::sum(self : StatsdistwishartCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartCursor::mean(self : StatsdistwishartCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartCursor::scale(self : StatsdistwishartCursor, f : Double) -> StatsdistwishartCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartCursor::add(self : StatsdistwishartCursor, other : StatsdistwishartCursor) -> StatsdistwishartCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartCursor::copy(self : StatsdistwishartCursor) -> StatsdistwishartCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartCursor::fill(self : StatsdistwishartCursor, v : Double) -> StatsdistwishartCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartCursor::min(self : StatsdistwishartCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartCursor::max(self : StatsdistwishartCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartCursor::to_string(self : StatsdistwishartCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_view_make(size : Int) -> StatsdistwishartView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartView::len(self : StatsdistwishartView) -> Int { self.size }

pub fn StatsdistwishartView::get(self : StatsdistwishartView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartView::set(self : StatsdistwishartView, i : Int, v : Double) -> StatsdistwishartView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartView::sum(self : StatsdistwishartView) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartView::mean(self : StatsdistwishartView) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartView::scale(self : StatsdistwishartView, f : Double) -> StatsdistwishartView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartView::add(self : StatsdistwishartView, other : StatsdistwishartView) -> StatsdistwishartView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartView::copy(self : StatsdistwishartView) -> StatsdistwishartView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartView::fill(self : StatsdistwishartView, v : Double) -> StatsdistwishartView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartView::min(self : StatsdistwishartView) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartView::max(self : StatsdistwishartView) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartView::to_string(self : StatsdistwishartView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_range_make(size : Int) -> StatsdistwishartRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartRange::len(self : StatsdistwishartRange) -> Int { self.size }

pub fn StatsdistwishartRange::get(self : StatsdistwishartRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartRange::set(self : StatsdistwishartRange, i : Int, v : Double) -> StatsdistwishartRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartRange::sum(self : StatsdistwishartRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartRange::mean(self : StatsdistwishartRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartRange::scale(self : StatsdistwishartRange, f : Double) -> StatsdistwishartRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartRange::add(self : StatsdistwishartRange, other : StatsdistwishartRange) -> StatsdistwishartRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartRange::copy(self : StatsdistwishartRange) -> StatsdistwishartRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartRange::fill(self : StatsdistwishartRange, v : Double) -> StatsdistwishartRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartRange::min(self : StatsdistwishartRange) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartRange::max(self : StatsdistwishartRange) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartRange::to_string(self : StatsdistwishartRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_slice_make(size : Int) -> StatsdistwishartSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistwishartSlice::len(self : StatsdistwishartSlice) -> Int { self.size }

pub fn StatsdistwishartSlice::get(self : StatsdistwishartSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistwishartSlice::set(self : StatsdistwishartSlice, i : Int, v : Double) -> StatsdistwishartSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistwishartSlice::sum(self : StatsdistwishartSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistwishartSlice::mean(self : StatsdistwishartSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistwishartSlice::scale(self : StatsdistwishartSlice, f : Double) -> StatsdistwishartSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartSlice::add(self : StatsdistwishartSlice, other : StatsdistwishartSlice) -> StatsdistwishartSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistwishartSlice::copy(self : StatsdistwishartSlice) -> StatsdistwishartSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartSlice::fill(self : StatsdistwishartSlice, v : Double) -> StatsdistwishartSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistwishartSlice::min(self : StatsdistwishartSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistwishartSlice::max(self : StatsdistwishartSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistwishartSlice::to_string(self : StatsdistwishartSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

