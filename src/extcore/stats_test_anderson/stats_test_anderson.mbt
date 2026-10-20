///===
/// extcore/stats_test_anderson

pub(all) struct StatstestandersonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_anderson_make_point(x : Double, y : Double) -> StatstestandersonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_anderson_make_point3(x : Double, y : Double, z : Double) -> StatstestandersonPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestandersonPoint::x(self : StatstestandersonPoint) -> Double { self.x }

pub fn StatstestandersonPoint::y(self : StatstestandersonPoint) -> Double { self.y }

pub fn StatstestandersonPoint::z(self : StatstestandersonPoint) -> Double { self.z }

pub fn StatstestandersonPoint::label(self : StatstestandersonPoint) -> Int { self.label }

pub fn StatstestandersonPoint::dist(self : StatstestandersonPoint, other : StatstestandersonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestandersonPoint::add(self : StatstestandersonPoint, other : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestandersonPoint::sub(self : StatstestandersonPoint, other : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestandersonPoint::scale(self : StatstestandersonPoint, s : Double) -> StatstestandersonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestandersonPoint::dot(self : StatstestandersonPoint, other : StatstestandersonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestandersonPoint::cross(self : StatstestandersonPoint, other : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestandersonPoint::norm(self : StatstestandersonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestandersonPoint::normalize(self : StatstestandersonPoint) -> StatstestandersonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestandersonPoint::negate(self : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestandersonPoint::mid(self : StatstestandersonPoint, other : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestandersonPoint::lerp(self : StatstestandersonPoint, other : StatstestandersonPoint, t : Double) -> StatstestandersonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestandersonPoint::to_string(self : StatstestandersonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestandersonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_anderson_make_series(vals : Array[Double], name : String) -> StatstestandersonSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestandersonSeries::len(self : StatstestandersonSeries) -> Int { self.vals.length() }

pub fn StatstestandersonSeries::sum(self : StatstestandersonSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestandersonSeries::mean(self : StatstestandersonSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestandersonSeries::min(self : StatstestandersonSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestandersonSeries::max(self : StatstestandersonSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestandersonSeries::range(self : StatstestandersonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestandersonSeries::variance(self : StatstestandersonSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestandersonSeries::std(self : StatstestandersonSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestandersonSeries::median(self : StatstestandersonSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestandersonSeries::scale(self : StatstestandersonSeries, f : Double) -> StatstestandersonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestandersonSeries::add(self : StatstestandersonSeries, other : StatstestandersonSeries) -> StatstestandersonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestandersonSeries::sub(self : StatstestandersonSeries, other : StatstestandersonSeries) -> StatstestandersonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestandersonSeries::normalize(self : StatstestandersonSeries) -> StatstestandersonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestandersonSeries::cumsum(self : StatstestandersonSeries) -> StatstestandersonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestandersonSeries::to_string(self : StatstestandersonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestandersonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_anderson_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestandersonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_anderson_matrix_identity(n : Int) -> StatstestandersonMatrix {
  let m = stats_test_anderson_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestandersonMatrix::get(self : StatstestandersonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestandersonMatrix::transpose(self : StatstestandersonMatrix) -> StatstestandersonMatrix {
  let result = stats_test_anderson_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestandersonMatrix::add(self : StatstestandersonMatrix, other : StatstestandersonMatrix) -> StatstestandersonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_anderson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestandersonMatrix::scale(self : StatstestandersonMatrix, s : Double) -> StatstestandersonMatrix {
  let result = stats_test_anderson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestandersonMatrix::multiply(self : StatstestandersonMatrix, other : StatstestandersonMatrix) -> StatstestandersonMatrix {
  if self.cols != other.rows { return stats_test_anderson_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_anderson_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatstestandersonMatrix::trace(self : StatstestandersonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestandersonMatrix::det(self : StatstestandersonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestandersonMatrix::norm(self : StatstestandersonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestandersonMatrix::to_string(self : StatstestandersonMatrix) -> String {
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

pub(all) struct StatstestandersonVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_anderson_make_vector(comps : Array[Double]) -> StatstestandersonVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_anderson_vector_zero(dim : Int) -> StatstestandersonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestandersonVector::add(self : StatstestandersonVector, other : StatstestandersonVector) -> StatstestandersonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestandersonVector::sub(self : StatstestandersonVector, other : StatstestandersonVector) -> StatstestandersonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestandersonVector::scale(self : StatstestandersonVector, s : Double) -> StatstestandersonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestandersonVector::dot(self : StatstestandersonVector, other : StatstestandersonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestandersonVector::norm(self : StatstestandersonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestandersonVector::normalize(self : StatstestandersonVector) -> StatstestandersonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestandersonVector::dist(self : StatstestandersonVector, other : StatstestandersonVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestandersonVector::to_string(self : StatstestandersonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestandersonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_frame_make(size : Int) -> StatstestandersonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonFrame::len(self : StatstestandersonFrame) -> Int { self.size }

pub fn StatstestandersonFrame::get(self : StatstestandersonFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonFrame::set(self : StatstestandersonFrame, i : Int, v : Double) -> StatstestandersonFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonFrame::sum(self : StatstestandersonFrame) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonFrame::mean(self : StatstestandersonFrame) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonFrame::scale(self : StatstestandersonFrame, f : Double) -> StatstestandersonFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonFrame::add(self : StatstestandersonFrame, other : StatstestandersonFrame) -> StatstestandersonFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonFrame::copy(self : StatstestandersonFrame) -> StatstestandersonFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonFrame::fill(self : StatstestandersonFrame, v : Double) -> StatstestandersonFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonFrame::min(self : StatstestandersonFrame) -> Double { @_common.min(self.data) }

pub fn StatstestandersonFrame::max(self : StatstestandersonFrame) -> Double { @_common.max(self.data) }

pub fn StatstestandersonFrame::to_string(self : StatstestandersonFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_table_make(size : Int) -> StatstestandersonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonTable::len(self : StatstestandersonTable) -> Int { self.size }

pub fn StatstestandersonTable::get(self : StatstestandersonTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonTable::set(self : StatstestandersonTable, i : Int, v : Double) -> StatstestandersonTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonTable::sum(self : StatstestandersonTable) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonTable::mean(self : StatstestandersonTable) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonTable::scale(self : StatstestandersonTable, f : Double) -> StatstestandersonTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonTable::add(self : StatstestandersonTable, other : StatstestandersonTable) -> StatstestandersonTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonTable::copy(self : StatstestandersonTable) -> StatstestandersonTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonTable::fill(self : StatstestandersonTable, v : Double) -> StatstestandersonTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonTable::min(self : StatstestandersonTable) -> Double { @_common.min(self.data) }

pub fn StatstestandersonTable::max(self : StatstestandersonTable) -> Double { @_common.max(self.data) }

pub fn StatstestandersonTable::to_string(self : StatstestandersonTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_graphn_make(size : Int) -> StatstestandersonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonGraphN::len(self : StatstestandersonGraphN) -> Int { self.size }

pub fn StatstestandersonGraphN::get(self : StatstestandersonGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonGraphN::set(self : StatstestandersonGraphN, i : Int, v : Double) -> StatstestandersonGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonGraphN::sum(self : StatstestandersonGraphN) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonGraphN::mean(self : StatstestandersonGraphN) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonGraphN::scale(self : StatstestandersonGraphN, f : Double) -> StatstestandersonGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonGraphN::add(self : StatstestandersonGraphN, other : StatstestandersonGraphN) -> StatstestandersonGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonGraphN::copy(self : StatstestandersonGraphN) -> StatstestandersonGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonGraphN::fill(self : StatstestandersonGraphN, v : Double) -> StatstestandersonGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonGraphN::min(self : StatstestandersonGraphN) -> Double { @_common.min(self.data) }

pub fn StatstestandersonGraphN::max(self : StatstestandersonGraphN) -> Double { @_common.max(self.data) }

pub fn StatstestandersonGraphN::to_string(self : StatstestandersonGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_node_make(size : Int) -> StatstestandersonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonNode::len(self : StatstestandersonNode) -> Int { self.size }

pub fn StatstestandersonNode::get(self : StatstestandersonNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonNode::set(self : StatstestandersonNode, i : Int, v : Double) -> StatstestandersonNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonNode::sum(self : StatstestandersonNode) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonNode::mean(self : StatstestandersonNode) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonNode::scale(self : StatstestandersonNode, f : Double) -> StatstestandersonNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonNode::add(self : StatstestandersonNode, other : StatstestandersonNode) -> StatstestandersonNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonNode::copy(self : StatstestandersonNode) -> StatstestandersonNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonNode::fill(self : StatstestandersonNode, v : Double) -> StatstestandersonNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonNode::min(self : StatstestandersonNode) -> Double { @_common.min(self.data) }

pub fn StatstestandersonNode::max(self : StatstestandersonNode) -> Double { @_common.max(self.data) }

pub fn StatstestandersonNode::to_string(self : StatstestandersonNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_edge_make(size : Int) -> StatstestandersonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonEdge::len(self : StatstestandersonEdge) -> Int { self.size }

pub fn StatstestandersonEdge::get(self : StatstestandersonEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonEdge::set(self : StatstestandersonEdge, i : Int, v : Double) -> StatstestandersonEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonEdge::sum(self : StatstestandersonEdge) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonEdge::mean(self : StatstestandersonEdge) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonEdge::scale(self : StatstestandersonEdge, f : Double) -> StatstestandersonEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonEdge::add(self : StatstestandersonEdge, other : StatstestandersonEdge) -> StatstestandersonEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonEdge::copy(self : StatstestandersonEdge) -> StatstestandersonEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonEdge::fill(self : StatstestandersonEdge, v : Double) -> StatstestandersonEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonEdge::min(self : StatstestandersonEdge) -> Double { @_common.min(self.data) }

pub fn StatstestandersonEdge::max(self : StatstestandersonEdge) -> Double { @_common.max(self.data) }

pub fn StatstestandersonEdge::to_string(self : StatstestandersonEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_path_make(size : Int) -> StatstestandersonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonPath::len(self : StatstestandersonPath) -> Int { self.size }

pub fn StatstestandersonPath::get(self : StatstestandersonPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonPath::set(self : StatstestandersonPath, i : Int, v : Double) -> StatstestandersonPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonPath::sum(self : StatstestandersonPath) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonPath::mean(self : StatstestandersonPath) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonPath::scale(self : StatstestandersonPath, f : Double) -> StatstestandersonPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonPath::add(self : StatstestandersonPath, other : StatstestandersonPath) -> StatstestandersonPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonPath::copy(self : StatstestandersonPath) -> StatstestandersonPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonPath::fill(self : StatstestandersonPath, v : Double) -> StatstestandersonPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonPath::min(self : StatstestandersonPath) -> Double { @_common.min(self.data) }

pub fn StatstestandersonPath::max(self : StatstestandersonPath) -> Double { @_common.max(self.data) }

pub fn StatstestandersonPath::to_string(self : StatstestandersonPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_cluster_make(size : Int) -> StatstestandersonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonCluster::len(self : StatstestandersonCluster) -> Int { self.size }

pub fn StatstestandersonCluster::get(self : StatstestandersonCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonCluster::set(self : StatstestandersonCluster, i : Int, v : Double) -> StatstestandersonCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonCluster::sum(self : StatstestandersonCluster) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonCluster::mean(self : StatstestandersonCluster) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonCluster::scale(self : StatstestandersonCluster, f : Double) -> StatstestandersonCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonCluster::add(self : StatstestandersonCluster, other : StatstestandersonCluster) -> StatstestandersonCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonCluster::copy(self : StatstestandersonCluster) -> StatstestandersonCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonCluster::fill(self : StatstestandersonCluster, v : Double) -> StatstestandersonCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonCluster::min(self : StatstestandersonCluster) -> Double { @_common.min(self.data) }

pub fn StatstestandersonCluster::max(self : StatstestandersonCluster) -> Double { @_common.max(self.data) }

pub fn StatstestandersonCluster::to_string(self : StatstestandersonCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_model_make(size : Int) -> StatstestandersonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonModel::len(self : StatstestandersonModel) -> Int { self.size }

pub fn StatstestandersonModel::get(self : StatstestandersonModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonModel::set(self : StatstestandersonModel, i : Int, v : Double) -> StatstestandersonModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonModel::sum(self : StatstestandersonModel) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonModel::mean(self : StatstestandersonModel) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonModel::scale(self : StatstestandersonModel, f : Double) -> StatstestandersonModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonModel::add(self : StatstestandersonModel, other : StatstestandersonModel) -> StatstestandersonModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonModel::copy(self : StatstestandersonModel) -> StatstestandersonModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonModel::fill(self : StatstestandersonModel, v : Double) -> StatstestandersonModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonModel::min(self : StatstestandersonModel) -> Double { @_common.min(self.data) }

pub fn StatstestandersonModel::max(self : StatstestandersonModel) -> Double { @_common.max(self.data) }

pub fn StatstestandersonModel::to_string(self : StatstestandersonModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_layer_make(size : Int) -> StatstestandersonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonLayer::len(self : StatstestandersonLayer) -> Int { self.size }

pub fn StatstestandersonLayer::get(self : StatstestandersonLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonLayer::set(self : StatstestandersonLayer, i : Int, v : Double) -> StatstestandersonLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonLayer::sum(self : StatstestandersonLayer) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonLayer::mean(self : StatstestandersonLayer) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonLayer::scale(self : StatstestandersonLayer, f : Double) -> StatstestandersonLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonLayer::add(self : StatstestandersonLayer, other : StatstestandersonLayer) -> StatstestandersonLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonLayer::copy(self : StatstestandersonLayer) -> StatstestandersonLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonLayer::fill(self : StatstestandersonLayer, v : Double) -> StatstestandersonLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonLayer::min(self : StatstestandersonLayer) -> Double { @_common.min(self.data) }

pub fn StatstestandersonLayer::max(self : StatstestandersonLayer) -> Double { @_common.max(self.data) }

pub fn StatstestandersonLayer::to_string(self : StatstestandersonLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_buffer_make(size : Int) -> StatstestandersonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonBuffer::len(self : StatstestandersonBuffer) -> Int { self.size }

pub fn StatstestandersonBuffer::get(self : StatstestandersonBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonBuffer::set(self : StatstestandersonBuffer, i : Int, v : Double) -> StatstestandersonBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonBuffer::sum(self : StatstestandersonBuffer) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonBuffer::mean(self : StatstestandersonBuffer) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonBuffer::scale(self : StatstestandersonBuffer, f : Double) -> StatstestandersonBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonBuffer::add(self : StatstestandersonBuffer, other : StatstestandersonBuffer) -> StatstestandersonBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonBuffer::copy(self : StatstestandersonBuffer) -> StatstestandersonBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonBuffer::fill(self : StatstestandersonBuffer, v : Double) -> StatstestandersonBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonBuffer::min(self : StatstestandersonBuffer) -> Double { @_common.min(self.data) }

pub fn StatstestandersonBuffer::max(self : StatstestandersonBuffer) -> Double { @_common.max(self.data) }

pub fn StatstestandersonBuffer::to_string(self : StatstestandersonBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_cursor_make(size : Int) -> StatstestandersonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonCursor::len(self : StatstestandersonCursor) -> Int { self.size }

pub fn StatstestandersonCursor::get(self : StatstestandersonCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonCursor::set(self : StatstestandersonCursor, i : Int, v : Double) -> StatstestandersonCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonCursor::sum(self : StatstestandersonCursor) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonCursor::mean(self : StatstestandersonCursor) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonCursor::scale(self : StatstestandersonCursor, f : Double) -> StatstestandersonCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonCursor::add(self : StatstestandersonCursor, other : StatstestandersonCursor) -> StatstestandersonCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonCursor::copy(self : StatstestandersonCursor) -> StatstestandersonCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonCursor::fill(self : StatstestandersonCursor, v : Double) -> StatstestandersonCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonCursor::min(self : StatstestandersonCursor) -> Double { @_common.min(self.data) }

pub fn StatstestandersonCursor::max(self : StatstestandersonCursor) -> Double { @_common.max(self.data) }

pub fn StatstestandersonCursor::to_string(self : StatstestandersonCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_view_make(size : Int) -> StatstestandersonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonView::len(self : StatstestandersonView) -> Int { self.size }

pub fn StatstestandersonView::get(self : StatstestandersonView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonView::set(self : StatstestandersonView, i : Int, v : Double) -> StatstestandersonView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonView::sum(self : StatstestandersonView) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonView::mean(self : StatstestandersonView) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonView::scale(self : StatstestandersonView, f : Double) -> StatstestandersonView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonView::add(self : StatstestandersonView, other : StatstestandersonView) -> StatstestandersonView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonView::copy(self : StatstestandersonView) -> StatstestandersonView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonView::fill(self : StatstestandersonView, v : Double) -> StatstestandersonView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonView::min(self : StatstestandersonView) -> Double { @_common.min(self.data) }

pub fn StatstestandersonView::max(self : StatstestandersonView) -> Double { @_common.max(self.data) }

pub fn StatstestandersonView::to_string(self : StatstestandersonView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_range_make(size : Int) -> StatstestandersonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonRange::len(self : StatstestandersonRange) -> Int { self.size }

pub fn StatstestandersonRange::get(self : StatstestandersonRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonRange::set(self : StatstestandersonRange, i : Int, v : Double) -> StatstestandersonRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonRange::sum(self : StatstestandersonRange) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonRange::mean(self : StatstestandersonRange) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonRange::scale(self : StatstestandersonRange, f : Double) -> StatstestandersonRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonRange::add(self : StatstestandersonRange, other : StatstestandersonRange) -> StatstestandersonRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonRange::copy(self : StatstestandersonRange) -> StatstestandersonRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonRange::fill(self : StatstestandersonRange, v : Double) -> StatstestandersonRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonRange::min(self : StatstestandersonRange) -> Double { @_common.min(self.data) }

pub fn StatstestandersonRange::max(self : StatstestandersonRange) -> Double { @_common.max(self.data) }

pub fn StatstestandersonRange::to_string(self : StatstestandersonRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestandersonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_slice_make(size : Int) -> StatstestandersonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestandersonSlice::len(self : StatstestandersonSlice) -> Int { self.size }

pub fn StatstestandersonSlice::get(self : StatstestandersonSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestandersonSlice::set(self : StatstestandersonSlice, i : Int, v : Double) -> StatstestandersonSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestandersonSlice::sum(self : StatstestandersonSlice) -> Double { @_common.sum(self.data) }

pub fn StatstestandersonSlice::mean(self : StatstestandersonSlice) -> Double { @_common.mean(self.data) }

pub fn StatstestandersonSlice::scale(self : StatstestandersonSlice, f : Double) -> StatstestandersonSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestandersonSlice::add(self : StatstestandersonSlice, other : StatstestandersonSlice) -> StatstestandersonSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestandersonSlice::copy(self : StatstestandersonSlice) -> StatstestandersonSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestandersonSlice::fill(self : StatstestandersonSlice, v : Double) -> StatstestandersonSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestandersonSlice::min(self : StatstestandersonSlice) -> Double { @_common.min(self.data) }

pub fn StatstestandersonSlice::max(self : StatstestandersonSlice) -> Double { @_common.max(self.data) }

pub fn StatstestandersonSlice::to_string(self : StatstestandersonSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

