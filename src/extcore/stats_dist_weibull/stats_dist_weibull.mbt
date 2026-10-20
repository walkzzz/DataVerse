///===
/// extcore/stats_dist_weibull

pub(all) struct StatsdistweibullPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_weibull_make_point(x : Double, y : Double) -> StatsdistweibullPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_weibull_make_point3(x : Double, y : Double, z : Double) -> StatsdistweibullPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistweibullPoint::x(self : StatsdistweibullPoint) -> Double { self.x }

pub fn StatsdistweibullPoint::y(self : StatsdistweibullPoint) -> Double { self.y }

pub fn StatsdistweibullPoint::z(self : StatsdistweibullPoint) -> Double { self.z }

pub fn StatsdistweibullPoint::label(self : StatsdistweibullPoint) -> Int { self.label }

pub fn StatsdistweibullPoint::dist(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistweibullPoint::add(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistweibullPoint::sub(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistweibullPoint::scale(self : StatsdistweibullPoint, s : Double) -> StatsdistweibullPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistweibullPoint::dot(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistweibullPoint::cross(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistweibullPoint::norm(self : StatsdistweibullPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistweibullPoint::normalize(self : StatsdistweibullPoint) -> StatsdistweibullPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistweibullPoint::negate(self : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistweibullPoint::mid(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistweibullPoint::lerp(self : StatsdistweibullPoint, other : StatsdistweibullPoint, t : Double) -> StatsdistweibullPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistweibullPoint::to_string(self : StatsdistweibullPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistweibullSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_weibull_make_series(vals : Array[Double], name : String) -> StatsdistweibullSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistweibullSeries::len(self : StatsdistweibullSeries) -> Int { self.vals.length() }

pub fn StatsdistweibullSeries::sum(self : StatsdistweibullSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistweibullSeries::mean(self : StatsdistweibullSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistweibullSeries::min(self : StatsdistweibullSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistweibullSeries::max(self : StatsdistweibullSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistweibullSeries::range(self : StatsdistweibullSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistweibullSeries::variance(self : StatsdistweibullSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistweibullSeries::std(self : StatsdistweibullSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistweibullSeries::median(self : StatsdistweibullSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistweibullSeries::scale(self : StatsdistweibullSeries, f : Double) -> StatsdistweibullSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistweibullSeries::add(self : StatsdistweibullSeries, other : StatsdistweibullSeries) -> StatsdistweibullSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistweibullSeries::sub(self : StatsdistweibullSeries, other : StatsdistweibullSeries) -> StatsdistweibullSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistweibullSeries::normalize(self : StatsdistweibullSeries) -> StatsdistweibullSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistweibullSeries::cumsum(self : StatsdistweibullSeries) -> StatsdistweibullSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistweibullSeries::to_string(self : StatsdistweibullSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistweibullMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_weibull_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistweibullMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_weibull_matrix_identity(n : Int) -> StatsdistweibullMatrix {
  let m = stats_dist_weibull_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistweibullMatrix::get(self : StatsdistweibullMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistweibullMatrix::transpose(self : StatsdistweibullMatrix) -> StatsdistweibullMatrix {
  let result = stats_dist_weibull_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistweibullMatrix::add(self : StatsdistweibullMatrix, other : StatsdistweibullMatrix) -> StatsdistweibullMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_weibull_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistweibullMatrix::scale(self : StatsdistweibullMatrix, s : Double) -> StatsdistweibullMatrix {
  let result = stats_dist_weibull_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistweibullMatrix::multiply(self : StatsdistweibullMatrix, other : StatsdistweibullMatrix) -> StatsdistweibullMatrix {
  if self.cols != other.rows { return stats_dist_weibull_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_weibull_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistweibullMatrix::trace(self : StatsdistweibullMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistweibullMatrix::det(self : StatsdistweibullMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistweibullMatrix::norm(self : StatsdistweibullMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistweibullMatrix::to_string(self : StatsdistweibullMatrix) -> String {
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

pub(all) struct StatsdistweibullVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_weibull_make_vector(comps : Array[Double]) -> StatsdistweibullVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_weibull_vector_zero(dim : Int) -> StatsdistweibullVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistweibullVector::add(self : StatsdistweibullVector, other : StatsdistweibullVector) -> StatsdistweibullVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistweibullVector::sub(self : StatsdistweibullVector, other : StatsdistweibullVector) -> StatsdistweibullVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistweibullVector::scale(self : StatsdistweibullVector, s : Double) -> StatsdistweibullVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistweibullVector::dot(self : StatsdistweibullVector, other : StatsdistweibullVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistweibullVector::norm(self : StatsdistweibullVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistweibullVector::normalize(self : StatsdistweibullVector) -> StatsdistweibullVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistweibullVector::dist(self : StatsdistweibullVector, other : StatsdistweibullVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistweibullVector::to_string(self : StatsdistweibullVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistweibullFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_frame_make(size : Int) -> StatsdistweibullFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullFrame::len(self : StatsdistweibullFrame) -> Int { self.size }

pub fn StatsdistweibullFrame::get(self : StatsdistweibullFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullFrame::set(self : StatsdistweibullFrame, i : Int, v : Double) -> StatsdistweibullFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullFrame::sum(self : StatsdistweibullFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullFrame::mean(self : StatsdistweibullFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullFrame::scale(self : StatsdistweibullFrame, f : Double) -> StatsdistweibullFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullFrame::add(self : StatsdistweibullFrame, other : StatsdistweibullFrame) -> StatsdistweibullFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullFrame::copy(self : StatsdistweibullFrame) -> StatsdistweibullFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullFrame::fill(self : StatsdistweibullFrame, v : Double) -> StatsdistweibullFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullFrame::min(self : StatsdistweibullFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullFrame::max(self : StatsdistweibullFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullFrame::to_string(self : StatsdistweibullFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_table_make(size : Int) -> StatsdistweibullTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullTable::len(self : StatsdistweibullTable) -> Int { self.size }

pub fn StatsdistweibullTable::get(self : StatsdistweibullTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullTable::set(self : StatsdistweibullTable, i : Int, v : Double) -> StatsdistweibullTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullTable::sum(self : StatsdistweibullTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullTable::mean(self : StatsdistweibullTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullTable::scale(self : StatsdistweibullTable, f : Double) -> StatsdistweibullTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullTable::add(self : StatsdistweibullTable, other : StatsdistweibullTable) -> StatsdistweibullTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullTable::copy(self : StatsdistweibullTable) -> StatsdistweibullTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullTable::fill(self : StatsdistweibullTable, v : Double) -> StatsdistweibullTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullTable::min(self : StatsdistweibullTable) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullTable::max(self : StatsdistweibullTable) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullTable::to_string(self : StatsdistweibullTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_graphn_make(size : Int) -> StatsdistweibullGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullGraphN::len(self : StatsdistweibullGraphN) -> Int { self.size }

pub fn StatsdistweibullGraphN::get(self : StatsdistweibullGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullGraphN::set(self : StatsdistweibullGraphN, i : Int, v : Double) -> StatsdistweibullGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullGraphN::sum(self : StatsdistweibullGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullGraphN::mean(self : StatsdistweibullGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullGraphN::scale(self : StatsdistweibullGraphN, f : Double) -> StatsdistweibullGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullGraphN::add(self : StatsdistweibullGraphN, other : StatsdistweibullGraphN) -> StatsdistweibullGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullGraphN::copy(self : StatsdistweibullGraphN) -> StatsdistweibullGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullGraphN::fill(self : StatsdistweibullGraphN, v : Double) -> StatsdistweibullGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullGraphN::min(self : StatsdistweibullGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullGraphN::max(self : StatsdistweibullGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullGraphN::to_string(self : StatsdistweibullGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_node_make(size : Int) -> StatsdistweibullNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullNode::len(self : StatsdistweibullNode) -> Int { self.size }

pub fn StatsdistweibullNode::get(self : StatsdistweibullNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullNode::set(self : StatsdistweibullNode, i : Int, v : Double) -> StatsdistweibullNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullNode::sum(self : StatsdistweibullNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullNode::mean(self : StatsdistweibullNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullNode::scale(self : StatsdistweibullNode, f : Double) -> StatsdistweibullNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullNode::add(self : StatsdistweibullNode, other : StatsdistweibullNode) -> StatsdistweibullNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullNode::copy(self : StatsdistweibullNode) -> StatsdistweibullNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullNode::fill(self : StatsdistweibullNode, v : Double) -> StatsdistweibullNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullNode::min(self : StatsdistweibullNode) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullNode::max(self : StatsdistweibullNode) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullNode::to_string(self : StatsdistweibullNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_edge_make(size : Int) -> StatsdistweibullEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullEdge::len(self : StatsdistweibullEdge) -> Int { self.size }

pub fn StatsdistweibullEdge::get(self : StatsdistweibullEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullEdge::set(self : StatsdistweibullEdge, i : Int, v : Double) -> StatsdistweibullEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullEdge::sum(self : StatsdistweibullEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullEdge::mean(self : StatsdistweibullEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullEdge::scale(self : StatsdistweibullEdge, f : Double) -> StatsdistweibullEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullEdge::add(self : StatsdistweibullEdge, other : StatsdistweibullEdge) -> StatsdistweibullEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullEdge::copy(self : StatsdistweibullEdge) -> StatsdistweibullEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullEdge::fill(self : StatsdistweibullEdge, v : Double) -> StatsdistweibullEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullEdge::min(self : StatsdistweibullEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullEdge::max(self : StatsdistweibullEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullEdge::to_string(self : StatsdistweibullEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_path_make(size : Int) -> StatsdistweibullPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullPath::len(self : StatsdistweibullPath) -> Int { self.size }

pub fn StatsdistweibullPath::get(self : StatsdistweibullPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullPath::set(self : StatsdistweibullPath, i : Int, v : Double) -> StatsdistweibullPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullPath::sum(self : StatsdistweibullPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullPath::mean(self : StatsdistweibullPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullPath::scale(self : StatsdistweibullPath, f : Double) -> StatsdistweibullPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullPath::add(self : StatsdistweibullPath, other : StatsdistweibullPath) -> StatsdistweibullPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullPath::copy(self : StatsdistweibullPath) -> StatsdistweibullPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullPath::fill(self : StatsdistweibullPath, v : Double) -> StatsdistweibullPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullPath::min(self : StatsdistweibullPath) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullPath::max(self : StatsdistweibullPath) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullPath::to_string(self : StatsdistweibullPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_cluster_make(size : Int) -> StatsdistweibullCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullCluster::len(self : StatsdistweibullCluster) -> Int { self.size }

pub fn StatsdistweibullCluster::get(self : StatsdistweibullCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullCluster::set(self : StatsdistweibullCluster, i : Int, v : Double) -> StatsdistweibullCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullCluster::sum(self : StatsdistweibullCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullCluster::mean(self : StatsdistweibullCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullCluster::scale(self : StatsdistweibullCluster, f : Double) -> StatsdistweibullCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullCluster::add(self : StatsdistweibullCluster, other : StatsdistweibullCluster) -> StatsdistweibullCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullCluster::copy(self : StatsdistweibullCluster) -> StatsdistweibullCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullCluster::fill(self : StatsdistweibullCluster, v : Double) -> StatsdistweibullCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullCluster::min(self : StatsdistweibullCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullCluster::max(self : StatsdistweibullCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullCluster::to_string(self : StatsdistweibullCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_model_make(size : Int) -> StatsdistweibullModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullModel::len(self : StatsdistweibullModel) -> Int { self.size }

pub fn StatsdistweibullModel::get(self : StatsdistweibullModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullModel::set(self : StatsdistweibullModel, i : Int, v : Double) -> StatsdistweibullModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullModel::sum(self : StatsdistweibullModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullModel::mean(self : StatsdistweibullModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullModel::scale(self : StatsdistweibullModel, f : Double) -> StatsdistweibullModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullModel::add(self : StatsdistweibullModel, other : StatsdistweibullModel) -> StatsdistweibullModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullModel::copy(self : StatsdistweibullModel) -> StatsdistweibullModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullModel::fill(self : StatsdistweibullModel, v : Double) -> StatsdistweibullModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullModel::min(self : StatsdistweibullModel) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullModel::max(self : StatsdistweibullModel) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullModel::to_string(self : StatsdistweibullModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_layer_make(size : Int) -> StatsdistweibullLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullLayer::len(self : StatsdistweibullLayer) -> Int { self.size }

pub fn StatsdistweibullLayer::get(self : StatsdistweibullLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullLayer::set(self : StatsdistweibullLayer, i : Int, v : Double) -> StatsdistweibullLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullLayer::sum(self : StatsdistweibullLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullLayer::mean(self : StatsdistweibullLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullLayer::scale(self : StatsdistweibullLayer, f : Double) -> StatsdistweibullLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullLayer::add(self : StatsdistweibullLayer, other : StatsdistweibullLayer) -> StatsdistweibullLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullLayer::copy(self : StatsdistweibullLayer) -> StatsdistweibullLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullLayer::fill(self : StatsdistweibullLayer, v : Double) -> StatsdistweibullLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullLayer::min(self : StatsdistweibullLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullLayer::max(self : StatsdistweibullLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullLayer::to_string(self : StatsdistweibullLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_buffer_make(size : Int) -> StatsdistweibullBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullBuffer::len(self : StatsdistweibullBuffer) -> Int { self.size }

pub fn StatsdistweibullBuffer::get(self : StatsdistweibullBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullBuffer::set(self : StatsdistweibullBuffer, i : Int, v : Double) -> StatsdistweibullBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullBuffer::sum(self : StatsdistweibullBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullBuffer::mean(self : StatsdistweibullBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullBuffer::scale(self : StatsdistweibullBuffer, f : Double) -> StatsdistweibullBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullBuffer::add(self : StatsdistweibullBuffer, other : StatsdistweibullBuffer) -> StatsdistweibullBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullBuffer::copy(self : StatsdistweibullBuffer) -> StatsdistweibullBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullBuffer::fill(self : StatsdistweibullBuffer, v : Double) -> StatsdistweibullBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullBuffer::min(self : StatsdistweibullBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullBuffer::max(self : StatsdistweibullBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullBuffer::to_string(self : StatsdistweibullBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_cursor_make(size : Int) -> StatsdistweibullCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullCursor::len(self : StatsdistweibullCursor) -> Int { self.size }

pub fn StatsdistweibullCursor::get(self : StatsdistweibullCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullCursor::set(self : StatsdistweibullCursor, i : Int, v : Double) -> StatsdistweibullCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullCursor::sum(self : StatsdistweibullCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullCursor::mean(self : StatsdistweibullCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullCursor::scale(self : StatsdistweibullCursor, f : Double) -> StatsdistweibullCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullCursor::add(self : StatsdistweibullCursor, other : StatsdistweibullCursor) -> StatsdistweibullCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullCursor::copy(self : StatsdistweibullCursor) -> StatsdistweibullCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullCursor::fill(self : StatsdistweibullCursor, v : Double) -> StatsdistweibullCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullCursor::min(self : StatsdistweibullCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullCursor::max(self : StatsdistweibullCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullCursor::to_string(self : StatsdistweibullCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_view_make(size : Int) -> StatsdistweibullView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullView::len(self : StatsdistweibullView) -> Int { self.size }

pub fn StatsdistweibullView::get(self : StatsdistweibullView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullView::set(self : StatsdistweibullView, i : Int, v : Double) -> StatsdistweibullView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullView::sum(self : StatsdistweibullView) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullView::mean(self : StatsdistweibullView) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullView::scale(self : StatsdistweibullView, f : Double) -> StatsdistweibullView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullView::add(self : StatsdistweibullView, other : StatsdistweibullView) -> StatsdistweibullView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullView::copy(self : StatsdistweibullView) -> StatsdistweibullView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullView::fill(self : StatsdistweibullView, v : Double) -> StatsdistweibullView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullView::min(self : StatsdistweibullView) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullView::max(self : StatsdistweibullView) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullView::to_string(self : StatsdistweibullView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_range_make(size : Int) -> StatsdistweibullRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullRange::len(self : StatsdistweibullRange) -> Int { self.size }

pub fn StatsdistweibullRange::get(self : StatsdistweibullRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullRange::set(self : StatsdistweibullRange, i : Int, v : Double) -> StatsdistweibullRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullRange::sum(self : StatsdistweibullRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullRange::mean(self : StatsdistweibullRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullRange::scale(self : StatsdistweibullRange, f : Double) -> StatsdistweibullRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullRange::add(self : StatsdistweibullRange, other : StatsdistweibullRange) -> StatsdistweibullRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullRange::copy(self : StatsdistweibullRange) -> StatsdistweibullRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullRange::fill(self : StatsdistweibullRange, v : Double) -> StatsdistweibullRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullRange::min(self : StatsdistweibullRange) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullRange::max(self : StatsdistweibullRange) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullRange::to_string(self : StatsdistweibullRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_slice_make(size : Int) -> StatsdistweibullSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistweibullSlice::len(self : StatsdistweibullSlice) -> Int { self.size }

pub fn StatsdistweibullSlice::get(self : StatsdistweibullSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistweibullSlice::set(self : StatsdistweibullSlice, i : Int, v : Double) -> StatsdistweibullSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistweibullSlice::sum(self : StatsdistweibullSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistweibullSlice::mean(self : StatsdistweibullSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistweibullSlice::scale(self : StatsdistweibullSlice, f : Double) -> StatsdistweibullSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullSlice::add(self : StatsdistweibullSlice, other : StatsdistweibullSlice) -> StatsdistweibullSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistweibullSlice::copy(self : StatsdistweibullSlice) -> StatsdistweibullSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullSlice::fill(self : StatsdistweibullSlice, v : Double) -> StatsdistweibullSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistweibullSlice::min(self : StatsdistweibullSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistweibullSlice::max(self : StatsdistweibullSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistweibullSlice::to_string(self : StatsdistweibullSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

