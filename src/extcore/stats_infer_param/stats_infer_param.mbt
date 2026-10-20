///===
/// extcore/stats_infer_param

pub(all) struct StatsinferparamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_param_make_point(x : Double, y : Double) -> StatsinferparamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_param_make_point3(x : Double, y : Double, z : Double) -> StatsinferparamPoint {
  { x, y, z, label: 0 }
}

pub fn StatsinferparamPoint::x(self : StatsinferparamPoint) -> Double { self.x }

pub fn StatsinferparamPoint::y(self : StatsinferparamPoint) -> Double { self.y }

pub fn StatsinferparamPoint::z(self : StatsinferparamPoint) -> Double { self.z }

pub fn StatsinferparamPoint::label(self : StatsinferparamPoint) -> Int { self.label }

pub fn StatsinferparamPoint::dist(self : StatsinferparamPoint, other : StatsinferparamPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsinferparamPoint::add(self : StatsinferparamPoint, other : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsinferparamPoint::sub(self : StatsinferparamPoint, other : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsinferparamPoint::scale(self : StatsinferparamPoint, s : Double) -> StatsinferparamPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsinferparamPoint::dot(self : StatsinferparamPoint, other : StatsinferparamPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsinferparamPoint::cross(self : StatsinferparamPoint, other : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsinferparamPoint::norm(self : StatsinferparamPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsinferparamPoint::normalize(self : StatsinferparamPoint) -> StatsinferparamPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferparamPoint::negate(self : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsinferparamPoint::mid(self : StatsinferparamPoint, other : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsinferparamPoint::lerp(self : StatsinferparamPoint, other : StatsinferparamPoint, t : Double) -> StatsinferparamPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsinferparamPoint::to_string(self : StatsinferparamPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsinferparamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_param_make_series(vals : Array[Double], name : String) -> StatsinferparamSeries {
  { vals, name, meta: 0 }
}

pub fn StatsinferparamSeries::len(self : StatsinferparamSeries) -> Int { self.vals.length() }

pub fn StatsinferparamSeries::sum(self : StatsinferparamSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsinferparamSeries::mean(self : StatsinferparamSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsinferparamSeries::min(self : StatsinferparamSeries) -> Double { @_common.min(self.vals) }

pub fn StatsinferparamSeries::max(self : StatsinferparamSeries) -> Double { @_common.max(self.vals) }

pub fn StatsinferparamSeries::range(self : StatsinferparamSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsinferparamSeries::variance(self : StatsinferparamSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsinferparamSeries::std(self : StatsinferparamSeries) -> Double { @_common.std(self.vals) }

pub fn StatsinferparamSeries::median(self : StatsinferparamSeries) -> Double { @_common.median(self.vals) }

pub fn StatsinferparamSeries::scale(self : StatsinferparamSeries, f : Double) -> StatsinferparamSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsinferparamSeries::add(self : StatsinferparamSeries, other : StatsinferparamSeries) -> StatsinferparamSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsinferparamSeries::sub(self : StatsinferparamSeries, other : StatsinferparamSeries) -> StatsinferparamSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsinferparamSeries::normalize(self : StatsinferparamSeries) -> StatsinferparamSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsinferparamSeries::cumsum(self : StatsinferparamSeries) -> StatsinferparamSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsinferparamSeries::to_string(self : StatsinferparamSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferparamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_param_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferparamMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn stats_infer_param_matrix_identity(n : Int) -> StatsinferparamMatrix {
  let m = stats_infer_param_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsinferparamMatrix::get(self : StatsinferparamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsinferparamMatrix::transpose(self : StatsinferparamMatrix) -> StatsinferparamMatrix {
  let result = stats_infer_param_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsinferparamMatrix::add(self : StatsinferparamMatrix, other : StatsinferparamMatrix) -> StatsinferparamMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_infer_param_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsinferparamMatrix::scale(self : StatsinferparamMatrix, s : Double) -> StatsinferparamMatrix {
  let result = stats_infer_param_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsinferparamMatrix::multiply(self : StatsinferparamMatrix, other : StatsinferparamMatrix) -> StatsinferparamMatrix {
  if self.cols != other.rows { return stats_infer_param_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_infer_param_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsinferparamMatrix::trace(self : StatsinferparamMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsinferparamMatrix::det(self : StatsinferparamMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsinferparamMatrix::norm(self : StatsinferparamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsinferparamMatrix::to_string(self : StatsinferparamMatrix) -> String {
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

pub(all) struct StatsinferparamVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_param_make_vector(comps : Array[Double]) -> StatsinferparamVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_param_vector_zero(dim : Int) -> StatsinferparamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsinferparamVector::add(self : StatsinferparamVector, other : StatsinferparamVector) -> StatsinferparamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferparamVector::sub(self : StatsinferparamVector, other : StatsinferparamVector) -> StatsinferparamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferparamVector::scale(self : StatsinferparamVector, s : Double) -> StatsinferparamVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsinferparamVector::dot(self : StatsinferparamVector, other : StatsinferparamVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsinferparamVector::norm(self : StatsinferparamVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsinferparamVector::normalize(self : StatsinferparamVector) -> StatsinferparamVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferparamVector::dist(self : StatsinferparamVector, other : StatsinferparamVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsinferparamVector::to_string(self : StatsinferparamVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferparamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_frame_make(size : Int) -> StatsinferparamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamFrame::len(self : StatsinferparamFrame) -> Int { self.size }

pub fn StatsinferparamFrame::get(self : StatsinferparamFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamFrame::set(self : StatsinferparamFrame, i : Int, v : Double) -> StatsinferparamFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamFrame::sum(self : StatsinferparamFrame) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamFrame::mean(self : StatsinferparamFrame) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamFrame::scale(self : StatsinferparamFrame, f : Double) -> StatsinferparamFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamFrame::add(self : StatsinferparamFrame, other : StatsinferparamFrame) -> StatsinferparamFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamFrame::copy(self : StatsinferparamFrame) -> StatsinferparamFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamFrame::fill(self : StatsinferparamFrame, v : Double) -> StatsinferparamFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamFrame::min(self : StatsinferparamFrame) -> Double { @_common.min(self.data) }

pub fn StatsinferparamFrame::max(self : StatsinferparamFrame) -> Double { @_common.max(self.data) }

pub fn StatsinferparamFrame::to_string(self : StatsinferparamFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_table_make(size : Int) -> StatsinferparamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamTable::len(self : StatsinferparamTable) -> Int { self.size }

pub fn StatsinferparamTable::get(self : StatsinferparamTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamTable::set(self : StatsinferparamTable, i : Int, v : Double) -> StatsinferparamTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamTable::sum(self : StatsinferparamTable) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamTable::mean(self : StatsinferparamTable) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamTable::scale(self : StatsinferparamTable, f : Double) -> StatsinferparamTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamTable::add(self : StatsinferparamTable, other : StatsinferparamTable) -> StatsinferparamTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamTable::copy(self : StatsinferparamTable) -> StatsinferparamTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamTable::fill(self : StatsinferparamTable, v : Double) -> StatsinferparamTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamTable::min(self : StatsinferparamTable) -> Double { @_common.min(self.data) }

pub fn StatsinferparamTable::max(self : StatsinferparamTable) -> Double { @_common.max(self.data) }

pub fn StatsinferparamTable::to_string(self : StatsinferparamTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_graphn_make(size : Int) -> StatsinferparamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamGraphN::len(self : StatsinferparamGraphN) -> Int { self.size }

pub fn StatsinferparamGraphN::get(self : StatsinferparamGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamGraphN::set(self : StatsinferparamGraphN, i : Int, v : Double) -> StatsinferparamGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamGraphN::sum(self : StatsinferparamGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamGraphN::mean(self : StatsinferparamGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamGraphN::scale(self : StatsinferparamGraphN, f : Double) -> StatsinferparamGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamGraphN::add(self : StatsinferparamGraphN, other : StatsinferparamGraphN) -> StatsinferparamGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamGraphN::copy(self : StatsinferparamGraphN) -> StatsinferparamGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamGraphN::fill(self : StatsinferparamGraphN, v : Double) -> StatsinferparamGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamGraphN::min(self : StatsinferparamGraphN) -> Double { @_common.min(self.data) }

pub fn StatsinferparamGraphN::max(self : StatsinferparamGraphN) -> Double { @_common.max(self.data) }

pub fn StatsinferparamGraphN::to_string(self : StatsinferparamGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_node_make(size : Int) -> StatsinferparamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamNode::len(self : StatsinferparamNode) -> Int { self.size }

pub fn StatsinferparamNode::get(self : StatsinferparamNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamNode::set(self : StatsinferparamNode, i : Int, v : Double) -> StatsinferparamNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamNode::sum(self : StatsinferparamNode) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamNode::mean(self : StatsinferparamNode) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamNode::scale(self : StatsinferparamNode, f : Double) -> StatsinferparamNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamNode::add(self : StatsinferparamNode, other : StatsinferparamNode) -> StatsinferparamNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamNode::copy(self : StatsinferparamNode) -> StatsinferparamNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamNode::fill(self : StatsinferparamNode, v : Double) -> StatsinferparamNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamNode::min(self : StatsinferparamNode) -> Double { @_common.min(self.data) }

pub fn StatsinferparamNode::max(self : StatsinferparamNode) -> Double { @_common.max(self.data) }

pub fn StatsinferparamNode::to_string(self : StatsinferparamNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_edge_make(size : Int) -> StatsinferparamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamEdge::len(self : StatsinferparamEdge) -> Int { self.size }

pub fn StatsinferparamEdge::get(self : StatsinferparamEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamEdge::set(self : StatsinferparamEdge, i : Int, v : Double) -> StatsinferparamEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamEdge::sum(self : StatsinferparamEdge) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamEdge::mean(self : StatsinferparamEdge) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamEdge::scale(self : StatsinferparamEdge, f : Double) -> StatsinferparamEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamEdge::add(self : StatsinferparamEdge, other : StatsinferparamEdge) -> StatsinferparamEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamEdge::copy(self : StatsinferparamEdge) -> StatsinferparamEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamEdge::fill(self : StatsinferparamEdge, v : Double) -> StatsinferparamEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamEdge::min(self : StatsinferparamEdge) -> Double { @_common.min(self.data) }

pub fn StatsinferparamEdge::max(self : StatsinferparamEdge) -> Double { @_common.max(self.data) }

pub fn StatsinferparamEdge::to_string(self : StatsinferparamEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_path_make(size : Int) -> StatsinferparamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamPath::len(self : StatsinferparamPath) -> Int { self.size }

pub fn StatsinferparamPath::get(self : StatsinferparamPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamPath::set(self : StatsinferparamPath, i : Int, v : Double) -> StatsinferparamPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamPath::sum(self : StatsinferparamPath) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamPath::mean(self : StatsinferparamPath) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamPath::scale(self : StatsinferparamPath, f : Double) -> StatsinferparamPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamPath::add(self : StatsinferparamPath, other : StatsinferparamPath) -> StatsinferparamPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamPath::copy(self : StatsinferparamPath) -> StatsinferparamPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamPath::fill(self : StatsinferparamPath, v : Double) -> StatsinferparamPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamPath::min(self : StatsinferparamPath) -> Double { @_common.min(self.data) }

pub fn StatsinferparamPath::max(self : StatsinferparamPath) -> Double { @_common.max(self.data) }

pub fn StatsinferparamPath::to_string(self : StatsinferparamPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_cluster_make(size : Int) -> StatsinferparamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamCluster::len(self : StatsinferparamCluster) -> Int { self.size }

pub fn StatsinferparamCluster::get(self : StatsinferparamCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamCluster::set(self : StatsinferparamCluster, i : Int, v : Double) -> StatsinferparamCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamCluster::sum(self : StatsinferparamCluster) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamCluster::mean(self : StatsinferparamCluster) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamCluster::scale(self : StatsinferparamCluster, f : Double) -> StatsinferparamCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamCluster::add(self : StatsinferparamCluster, other : StatsinferparamCluster) -> StatsinferparamCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamCluster::copy(self : StatsinferparamCluster) -> StatsinferparamCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamCluster::fill(self : StatsinferparamCluster, v : Double) -> StatsinferparamCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamCluster::min(self : StatsinferparamCluster) -> Double { @_common.min(self.data) }

pub fn StatsinferparamCluster::max(self : StatsinferparamCluster) -> Double { @_common.max(self.data) }

pub fn StatsinferparamCluster::to_string(self : StatsinferparamCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_model_make(size : Int) -> StatsinferparamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamModel::len(self : StatsinferparamModel) -> Int { self.size }

pub fn StatsinferparamModel::get(self : StatsinferparamModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamModel::set(self : StatsinferparamModel, i : Int, v : Double) -> StatsinferparamModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamModel::sum(self : StatsinferparamModel) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamModel::mean(self : StatsinferparamModel) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamModel::scale(self : StatsinferparamModel, f : Double) -> StatsinferparamModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamModel::add(self : StatsinferparamModel, other : StatsinferparamModel) -> StatsinferparamModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamModel::copy(self : StatsinferparamModel) -> StatsinferparamModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamModel::fill(self : StatsinferparamModel, v : Double) -> StatsinferparamModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamModel::min(self : StatsinferparamModel) -> Double { @_common.min(self.data) }

pub fn StatsinferparamModel::max(self : StatsinferparamModel) -> Double { @_common.max(self.data) }

pub fn StatsinferparamModel::to_string(self : StatsinferparamModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_layer_make(size : Int) -> StatsinferparamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamLayer::len(self : StatsinferparamLayer) -> Int { self.size }

pub fn StatsinferparamLayer::get(self : StatsinferparamLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamLayer::set(self : StatsinferparamLayer, i : Int, v : Double) -> StatsinferparamLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamLayer::sum(self : StatsinferparamLayer) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamLayer::mean(self : StatsinferparamLayer) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamLayer::scale(self : StatsinferparamLayer, f : Double) -> StatsinferparamLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamLayer::add(self : StatsinferparamLayer, other : StatsinferparamLayer) -> StatsinferparamLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamLayer::copy(self : StatsinferparamLayer) -> StatsinferparamLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamLayer::fill(self : StatsinferparamLayer, v : Double) -> StatsinferparamLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamLayer::min(self : StatsinferparamLayer) -> Double { @_common.min(self.data) }

pub fn StatsinferparamLayer::max(self : StatsinferparamLayer) -> Double { @_common.max(self.data) }

pub fn StatsinferparamLayer::to_string(self : StatsinferparamLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_buffer_make(size : Int) -> StatsinferparamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamBuffer::len(self : StatsinferparamBuffer) -> Int { self.size }

pub fn StatsinferparamBuffer::get(self : StatsinferparamBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamBuffer::set(self : StatsinferparamBuffer, i : Int, v : Double) -> StatsinferparamBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamBuffer::sum(self : StatsinferparamBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamBuffer::mean(self : StatsinferparamBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamBuffer::scale(self : StatsinferparamBuffer, f : Double) -> StatsinferparamBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamBuffer::add(self : StatsinferparamBuffer, other : StatsinferparamBuffer) -> StatsinferparamBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamBuffer::copy(self : StatsinferparamBuffer) -> StatsinferparamBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamBuffer::fill(self : StatsinferparamBuffer, v : Double) -> StatsinferparamBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamBuffer::min(self : StatsinferparamBuffer) -> Double { @_common.min(self.data) }

pub fn StatsinferparamBuffer::max(self : StatsinferparamBuffer) -> Double { @_common.max(self.data) }

pub fn StatsinferparamBuffer::to_string(self : StatsinferparamBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_cursor_make(size : Int) -> StatsinferparamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamCursor::len(self : StatsinferparamCursor) -> Int { self.size }

pub fn StatsinferparamCursor::get(self : StatsinferparamCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamCursor::set(self : StatsinferparamCursor, i : Int, v : Double) -> StatsinferparamCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamCursor::sum(self : StatsinferparamCursor) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamCursor::mean(self : StatsinferparamCursor) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamCursor::scale(self : StatsinferparamCursor, f : Double) -> StatsinferparamCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamCursor::add(self : StatsinferparamCursor, other : StatsinferparamCursor) -> StatsinferparamCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamCursor::copy(self : StatsinferparamCursor) -> StatsinferparamCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamCursor::fill(self : StatsinferparamCursor, v : Double) -> StatsinferparamCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamCursor::min(self : StatsinferparamCursor) -> Double { @_common.min(self.data) }

pub fn StatsinferparamCursor::max(self : StatsinferparamCursor) -> Double { @_common.max(self.data) }

pub fn StatsinferparamCursor::to_string(self : StatsinferparamCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_view_make(size : Int) -> StatsinferparamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamView::len(self : StatsinferparamView) -> Int { self.size }

pub fn StatsinferparamView::get(self : StatsinferparamView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamView::set(self : StatsinferparamView, i : Int, v : Double) -> StatsinferparamView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamView::sum(self : StatsinferparamView) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamView::mean(self : StatsinferparamView) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamView::scale(self : StatsinferparamView, f : Double) -> StatsinferparamView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamView::add(self : StatsinferparamView, other : StatsinferparamView) -> StatsinferparamView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamView::copy(self : StatsinferparamView) -> StatsinferparamView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamView::fill(self : StatsinferparamView, v : Double) -> StatsinferparamView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamView::min(self : StatsinferparamView) -> Double { @_common.min(self.data) }

pub fn StatsinferparamView::max(self : StatsinferparamView) -> Double { @_common.max(self.data) }

pub fn StatsinferparamView::to_string(self : StatsinferparamView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_range_make(size : Int) -> StatsinferparamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamRange::len(self : StatsinferparamRange) -> Int { self.size }

pub fn StatsinferparamRange::get(self : StatsinferparamRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamRange::set(self : StatsinferparamRange, i : Int, v : Double) -> StatsinferparamRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamRange::sum(self : StatsinferparamRange) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamRange::mean(self : StatsinferparamRange) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamRange::scale(self : StatsinferparamRange, f : Double) -> StatsinferparamRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamRange::add(self : StatsinferparamRange, other : StatsinferparamRange) -> StatsinferparamRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamRange::copy(self : StatsinferparamRange) -> StatsinferparamRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamRange::fill(self : StatsinferparamRange, v : Double) -> StatsinferparamRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamRange::min(self : StatsinferparamRange) -> Double { @_common.min(self.data) }

pub fn StatsinferparamRange::max(self : StatsinferparamRange) -> Double { @_common.max(self.data) }

pub fn StatsinferparamRange::to_string(self : StatsinferparamRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferparamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_slice_make(size : Int) -> StatsinferparamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferparamSlice::len(self : StatsinferparamSlice) -> Int { self.size }

pub fn StatsinferparamSlice::get(self : StatsinferparamSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferparamSlice::set(self : StatsinferparamSlice, i : Int, v : Double) -> StatsinferparamSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferparamSlice::sum(self : StatsinferparamSlice) -> Double { @_common.sum(self.data) }

pub fn StatsinferparamSlice::mean(self : StatsinferparamSlice) -> Double { @_common.mean(self.data) }

pub fn StatsinferparamSlice::scale(self : StatsinferparamSlice, f : Double) -> StatsinferparamSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferparamSlice::add(self : StatsinferparamSlice, other : StatsinferparamSlice) -> StatsinferparamSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferparamSlice::copy(self : StatsinferparamSlice) -> StatsinferparamSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferparamSlice::fill(self : StatsinferparamSlice, v : Double) -> StatsinferparamSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferparamSlice::min(self : StatsinferparamSlice) -> Double { @_common.min(self.data) }

pub fn StatsinferparamSlice::max(self : StatsinferparamSlice) -> Double { @_common.max(self.data) }

pub fn StatsinferparamSlice::to_string(self : StatsinferparamSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

