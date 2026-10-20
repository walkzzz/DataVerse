///===
/// extcore/stats_infer_nonparam

pub(all) struct StatsinfernonparamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_nonparam_make_point(x : Double, y : Double) -> StatsinfernonparamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_nonparam_make_point3(x : Double, y : Double, z : Double) -> StatsinfernonparamPoint {
  { x, y, z, label: 0 }
}

pub fn StatsinfernonparamPoint::x(self : StatsinfernonparamPoint) -> Double { self.x }

pub fn StatsinfernonparamPoint::y(self : StatsinfernonparamPoint) -> Double { self.y }

pub fn StatsinfernonparamPoint::z(self : StatsinfernonparamPoint) -> Double { self.z }

pub fn StatsinfernonparamPoint::label(self : StatsinfernonparamPoint) -> Int { self.label }

pub fn StatsinfernonparamPoint::dist(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsinfernonparamPoint::add(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsinfernonparamPoint::sub(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsinfernonparamPoint::scale(self : StatsinfernonparamPoint, s : Double) -> StatsinfernonparamPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsinfernonparamPoint::dot(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsinfernonparamPoint::cross(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsinfernonparamPoint::norm(self : StatsinfernonparamPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsinfernonparamPoint::normalize(self : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinfernonparamPoint::negate(self : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsinfernonparamPoint::mid(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsinfernonparamPoint::lerp(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint, t : Double) -> StatsinfernonparamPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsinfernonparamPoint::to_string(self : StatsinfernonparamPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsinfernonparamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_nonparam_make_series(vals : Array[Double], name : String) -> StatsinfernonparamSeries {
  { vals, name, meta: 0 }
}

pub fn StatsinfernonparamSeries::len(self : StatsinfernonparamSeries) -> Int { self.vals.length() }

pub fn StatsinfernonparamSeries::sum(self : StatsinfernonparamSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsinfernonparamSeries::mean(self : StatsinfernonparamSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsinfernonparamSeries::min(self : StatsinfernonparamSeries) -> Double { @_common.min(self.vals) }

pub fn StatsinfernonparamSeries::max(self : StatsinfernonparamSeries) -> Double { @_common.max(self.vals) }

pub fn StatsinfernonparamSeries::range(self : StatsinfernonparamSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsinfernonparamSeries::variance(self : StatsinfernonparamSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsinfernonparamSeries::std(self : StatsinfernonparamSeries) -> Double { @_common.std(self.vals) }

pub fn StatsinfernonparamSeries::median(self : StatsinfernonparamSeries) -> Double { @_common.median(self.vals) }

pub fn StatsinfernonparamSeries::scale(self : StatsinfernonparamSeries, f : Double) -> StatsinfernonparamSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsinfernonparamSeries::add(self : StatsinfernonparamSeries, other : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsinfernonparamSeries::sub(self : StatsinfernonparamSeries, other : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsinfernonparamSeries::normalize(self : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsinfernonparamSeries::cumsum(self : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsinfernonparamSeries::to_string(self : StatsinfernonparamSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinfernonparamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_nonparam_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinfernonparamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_nonparam_matrix_identity(n : Int) -> StatsinfernonparamMatrix {
  let m = stats_infer_nonparam_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsinfernonparamMatrix::get(self : StatsinfernonparamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsinfernonparamMatrix::transpose(self : StatsinfernonparamMatrix) -> StatsinfernonparamMatrix {
  let result = stats_infer_nonparam_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsinfernonparamMatrix::add(self : StatsinfernonparamMatrix, other : StatsinfernonparamMatrix) -> StatsinfernonparamMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_infer_nonparam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsinfernonparamMatrix::scale(self : StatsinfernonparamMatrix, s : Double) -> StatsinfernonparamMatrix {
  let result = stats_infer_nonparam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsinfernonparamMatrix::multiply(self : StatsinfernonparamMatrix, other : StatsinfernonparamMatrix) -> StatsinfernonparamMatrix {
  if self.cols != other.rows { return stats_infer_nonparam_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_infer_nonparam_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsinfernonparamMatrix::trace(self : StatsinfernonparamMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsinfernonparamMatrix::det(self : StatsinfernonparamMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsinfernonparamMatrix::norm(self : StatsinfernonparamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsinfernonparamMatrix::to_string(self : StatsinfernonparamMatrix) -> String {
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

pub(all) struct StatsinfernonparamVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_nonparam_make_vector(comps : Array[Double]) -> StatsinfernonparamVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_nonparam_vector_zero(dim : Int) -> StatsinfernonparamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsinfernonparamVector::add(self : StatsinfernonparamVector, other : StatsinfernonparamVector) -> StatsinfernonparamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinfernonparamVector::sub(self : StatsinfernonparamVector, other : StatsinfernonparamVector) -> StatsinfernonparamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinfernonparamVector::scale(self : StatsinfernonparamVector, s : Double) -> StatsinfernonparamVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsinfernonparamVector::dot(self : StatsinfernonparamVector, other : StatsinfernonparamVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsinfernonparamVector::norm(self : StatsinfernonparamVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsinfernonparamVector::normalize(self : StatsinfernonparamVector) -> StatsinfernonparamVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinfernonparamVector::dist(self : StatsinfernonparamVector, other : StatsinfernonparamVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsinfernonparamVector::to_string(self : StatsinfernonparamVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinfernonparamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_frame_make(size : Int) -> StatsinfernonparamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamFrame::len(self : StatsinfernonparamFrame) -> Int { self.size }

pub fn StatsinfernonparamFrame::get(self : StatsinfernonparamFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamFrame::set(self : StatsinfernonparamFrame, i : Int, v : Double) -> StatsinfernonparamFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamFrame::sum(self : StatsinfernonparamFrame) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamFrame::mean(self : StatsinfernonparamFrame) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamFrame::scale(self : StatsinfernonparamFrame, f : Double) -> StatsinfernonparamFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamFrame::add(self : StatsinfernonparamFrame, other : StatsinfernonparamFrame) -> StatsinfernonparamFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamFrame::copy(self : StatsinfernonparamFrame) -> StatsinfernonparamFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamFrame::fill(self : StatsinfernonparamFrame, v : Double) -> StatsinfernonparamFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamFrame::min(self : StatsinfernonparamFrame) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamFrame::max(self : StatsinfernonparamFrame) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamFrame::to_string(self : StatsinfernonparamFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_table_make(size : Int) -> StatsinfernonparamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamTable::len(self : StatsinfernonparamTable) -> Int { self.size }

pub fn StatsinfernonparamTable::get(self : StatsinfernonparamTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamTable::set(self : StatsinfernonparamTable, i : Int, v : Double) -> StatsinfernonparamTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamTable::sum(self : StatsinfernonparamTable) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamTable::mean(self : StatsinfernonparamTable) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamTable::scale(self : StatsinfernonparamTable, f : Double) -> StatsinfernonparamTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamTable::add(self : StatsinfernonparamTable, other : StatsinfernonparamTable) -> StatsinfernonparamTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamTable::copy(self : StatsinfernonparamTable) -> StatsinfernonparamTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamTable::fill(self : StatsinfernonparamTable, v : Double) -> StatsinfernonparamTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamTable::min(self : StatsinfernonparamTable) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamTable::max(self : StatsinfernonparamTable) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamTable::to_string(self : StatsinfernonparamTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_graphn_make(size : Int) -> StatsinfernonparamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamGraphN::len(self : StatsinfernonparamGraphN) -> Int { self.size }

pub fn StatsinfernonparamGraphN::get(self : StatsinfernonparamGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamGraphN::set(self : StatsinfernonparamGraphN, i : Int, v : Double) -> StatsinfernonparamGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamGraphN::sum(self : StatsinfernonparamGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamGraphN::mean(self : StatsinfernonparamGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamGraphN::scale(self : StatsinfernonparamGraphN, f : Double) -> StatsinfernonparamGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamGraphN::add(self : StatsinfernonparamGraphN, other : StatsinfernonparamGraphN) -> StatsinfernonparamGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamGraphN::copy(self : StatsinfernonparamGraphN) -> StatsinfernonparamGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamGraphN::fill(self : StatsinfernonparamGraphN, v : Double) -> StatsinfernonparamGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamGraphN::min(self : StatsinfernonparamGraphN) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamGraphN::max(self : StatsinfernonparamGraphN) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamGraphN::to_string(self : StatsinfernonparamGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_node_make(size : Int) -> StatsinfernonparamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamNode::len(self : StatsinfernonparamNode) -> Int { self.size }

pub fn StatsinfernonparamNode::get(self : StatsinfernonparamNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamNode::set(self : StatsinfernonparamNode, i : Int, v : Double) -> StatsinfernonparamNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamNode::sum(self : StatsinfernonparamNode) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamNode::mean(self : StatsinfernonparamNode) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamNode::scale(self : StatsinfernonparamNode, f : Double) -> StatsinfernonparamNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamNode::add(self : StatsinfernonparamNode, other : StatsinfernonparamNode) -> StatsinfernonparamNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamNode::copy(self : StatsinfernonparamNode) -> StatsinfernonparamNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamNode::fill(self : StatsinfernonparamNode, v : Double) -> StatsinfernonparamNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamNode::min(self : StatsinfernonparamNode) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamNode::max(self : StatsinfernonparamNode) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamNode::to_string(self : StatsinfernonparamNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_edge_make(size : Int) -> StatsinfernonparamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamEdge::len(self : StatsinfernonparamEdge) -> Int { self.size }

pub fn StatsinfernonparamEdge::get(self : StatsinfernonparamEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamEdge::set(self : StatsinfernonparamEdge, i : Int, v : Double) -> StatsinfernonparamEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamEdge::sum(self : StatsinfernonparamEdge) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamEdge::mean(self : StatsinfernonparamEdge) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamEdge::scale(self : StatsinfernonparamEdge, f : Double) -> StatsinfernonparamEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamEdge::add(self : StatsinfernonparamEdge, other : StatsinfernonparamEdge) -> StatsinfernonparamEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamEdge::copy(self : StatsinfernonparamEdge) -> StatsinfernonparamEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamEdge::fill(self : StatsinfernonparamEdge, v : Double) -> StatsinfernonparamEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamEdge::min(self : StatsinfernonparamEdge) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamEdge::max(self : StatsinfernonparamEdge) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamEdge::to_string(self : StatsinfernonparamEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_path_make(size : Int) -> StatsinfernonparamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamPath::len(self : StatsinfernonparamPath) -> Int { self.size }

pub fn StatsinfernonparamPath::get(self : StatsinfernonparamPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamPath::set(self : StatsinfernonparamPath, i : Int, v : Double) -> StatsinfernonparamPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamPath::sum(self : StatsinfernonparamPath) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamPath::mean(self : StatsinfernonparamPath) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamPath::scale(self : StatsinfernonparamPath, f : Double) -> StatsinfernonparamPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamPath::add(self : StatsinfernonparamPath, other : StatsinfernonparamPath) -> StatsinfernonparamPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamPath::copy(self : StatsinfernonparamPath) -> StatsinfernonparamPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamPath::fill(self : StatsinfernonparamPath, v : Double) -> StatsinfernonparamPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamPath::min(self : StatsinfernonparamPath) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamPath::max(self : StatsinfernonparamPath) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamPath::to_string(self : StatsinfernonparamPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_cluster_make(size : Int) -> StatsinfernonparamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamCluster::len(self : StatsinfernonparamCluster) -> Int { self.size }

pub fn StatsinfernonparamCluster::get(self : StatsinfernonparamCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamCluster::set(self : StatsinfernonparamCluster, i : Int, v : Double) -> StatsinfernonparamCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamCluster::sum(self : StatsinfernonparamCluster) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamCluster::mean(self : StatsinfernonparamCluster) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamCluster::scale(self : StatsinfernonparamCluster, f : Double) -> StatsinfernonparamCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamCluster::add(self : StatsinfernonparamCluster, other : StatsinfernonparamCluster) -> StatsinfernonparamCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamCluster::copy(self : StatsinfernonparamCluster) -> StatsinfernonparamCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamCluster::fill(self : StatsinfernonparamCluster, v : Double) -> StatsinfernonparamCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamCluster::min(self : StatsinfernonparamCluster) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamCluster::max(self : StatsinfernonparamCluster) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamCluster::to_string(self : StatsinfernonparamCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_model_make(size : Int) -> StatsinfernonparamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamModel::len(self : StatsinfernonparamModel) -> Int { self.size }

pub fn StatsinfernonparamModel::get(self : StatsinfernonparamModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamModel::set(self : StatsinfernonparamModel, i : Int, v : Double) -> StatsinfernonparamModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamModel::sum(self : StatsinfernonparamModel) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamModel::mean(self : StatsinfernonparamModel) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamModel::scale(self : StatsinfernonparamModel, f : Double) -> StatsinfernonparamModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamModel::add(self : StatsinfernonparamModel, other : StatsinfernonparamModel) -> StatsinfernonparamModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamModel::copy(self : StatsinfernonparamModel) -> StatsinfernonparamModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamModel::fill(self : StatsinfernonparamModel, v : Double) -> StatsinfernonparamModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamModel::min(self : StatsinfernonparamModel) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamModel::max(self : StatsinfernonparamModel) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamModel::to_string(self : StatsinfernonparamModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_layer_make(size : Int) -> StatsinfernonparamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamLayer::len(self : StatsinfernonparamLayer) -> Int { self.size }

pub fn StatsinfernonparamLayer::get(self : StatsinfernonparamLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamLayer::set(self : StatsinfernonparamLayer, i : Int, v : Double) -> StatsinfernonparamLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamLayer::sum(self : StatsinfernonparamLayer) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamLayer::mean(self : StatsinfernonparamLayer) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamLayer::scale(self : StatsinfernonparamLayer, f : Double) -> StatsinfernonparamLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamLayer::add(self : StatsinfernonparamLayer, other : StatsinfernonparamLayer) -> StatsinfernonparamLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamLayer::copy(self : StatsinfernonparamLayer) -> StatsinfernonparamLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamLayer::fill(self : StatsinfernonparamLayer, v : Double) -> StatsinfernonparamLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamLayer::min(self : StatsinfernonparamLayer) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamLayer::max(self : StatsinfernonparamLayer) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamLayer::to_string(self : StatsinfernonparamLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_buffer_make(size : Int) -> StatsinfernonparamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamBuffer::len(self : StatsinfernonparamBuffer) -> Int { self.size }

pub fn StatsinfernonparamBuffer::get(self : StatsinfernonparamBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamBuffer::set(self : StatsinfernonparamBuffer, i : Int, v : Double) -> StatsinfernonparamBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamBuffer::sum(self : StatsinfernonparamBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamBuffer::mean(self : StatsinfernonparamBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamBuffer::scale(self : StatsinfernonparamBuffer, f : Double) -> StatsinfernonparamBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamBuffer::add(self : StatsinfernonparamBuffer, other : StatsinfernonparamBuffer) -> StatsinfernonparamBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamBuffer::copy(self : StatsinfernonparamBuffer) -> StatsinfernonparamBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamBuffer::fill(self : StatsinfernonparamBuffer, v : Double) -> StatsinfernonparamBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamBuffer::min(self : StatsinfernonparamBuffer) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamBuffer::max(self : StatsinfernonparamBuffer) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamBuffer::to_string(self : StatsinfernonparamBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_cursor_make(size : Int) -> StatsinfernonparamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamCursor::len(self : StatsinfernonparamCursor) -> Int { self.size }

pub fn StatsinfernonparamCursor::get(self : StatsinfernonparamCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamCursor::set(self : StatsinfernonparamCursor, i : Int, v : Double) -> StatsinfernonparamCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamCursor::sum(self : StatsinfernonparamCursor) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamCursor::mean(self : StatsinfernonparamCursor) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamCursor::scale(self : StatsinfernonparamCursor, f : Double) -> StatsinfernonparamCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamCursor::add(self : StatsinfernonparamCursor, other : StatsinfernonparamCursor) -> StatsinfernonparamCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamCursor::copy(self : StatsinfernonparamCursor) -> StatsinfernonparamCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamCursor::fill(self : StatsinfernonparamCursor, v : Double) -> StatsinfernonparamCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamCursor::min(self : StatsinfernonparamCursor) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamCursor::max(self : StatsinfernonparamCursor) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamCursor::to_string(self : StatsinfernonparamCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_view_make(size : Int) -> StatsinfernonparamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamView::len(self : StatsinfernonparamView) -> Int { self.size }

pub fn StatsinfernonparamView::get(self : StatsinfernonparamView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamView::set(self : StatsinfernonparamView, i : Int, v : Double) -> StatsinfernonparamView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamView::sum(self : StatsinfernonparamView) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamView::mean(self : StatsinfernonparamView) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamView::scale(self : StatsinfernonparamView, f : Double) -> StatsinfernonparamView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamView::add(self : StatsinfernonparamView, other : StatsinfernonparamView) -> StatsinfernonparamView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamView::copy(self : StatsinfernonparamView) -> StatsinfernonparamView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamView::fill(self : StatsinfernonparamView, v : Double) -> StatsinfernonparamView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamView::min(self : StatsinfernonparamView) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamView::max(self : StatsinfernonparamView) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamView::to_string(self : StatsinfernonparamView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_range_make(size : Int) -> StatsinfernonparamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamRange::len(self : StatsinfernonparamRange) -> Int { self.size }

pub fn StatsinfernonparamRange::get(self : StatsinfernonparamRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamRange::set(self : StatsinfernonparamRange, i : Int, v : Double) -> StatsinfernonparamRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamRange::sum(self : StatsinfernonparamRange) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamRange::mean(self : StatsinfernonparamRange) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamRange::scale(self : StatsinfernonparamRange, f : Double) -> StatsinfernonparamRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamRange::add(self : StatsinfernonparamRange, other : StatsinfernonparamRange) -> StatsinfernonparamRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamRange::copy(self : StatsinfernonparamRange) -> StatsinfernonparamRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamRange::fill(self : StatsinfernonparamRange, v : Double) -> StatsinfernonparamRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamRange::min(self : StatsinfernonparamRange) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamRange::max(self : StatsinfernonparamRange) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamRange::to_string(self : StatsinfernonparamRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_slice_make(size : Int) -> StatsinfernonparamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinfernonparamSlice::len(self : StatsinfernonparamSlice) -> Int { self.size }

pub fn StatsinfernonparamSlice::get(self : StatsinfernonparamSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinfernonparamSlice::set(self : StatsinfernonparamSlice, i : Int, v : Double) -> StatsinfernonparamSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamSlice::sum(self : StatsinfernonparamSlice) -> Double { @_common.sum(self.data) }

pub fn StatsinfernonparamSlice::mean(self : StatsinfernonparamSlice) -> Double { @_common.mean(self.data) }

pub fn StatsinfernonparamSlice::scale(self : StatsinfernonparamSlice, f : Double) -> StatsinfernonparamSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamSlice::add(self : StatsinfernonparamSlice, other : StatsinfernonparamSlice) -> StatsinfernonparamSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinfernonparamSlice::copy(self : StatsinfernonparamSlice) -> StatsinfernonparamSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamSlice::fill(self : StatsinfernonparamSlice, v : Double) -> StatsinfernonparamSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinfernonparamSlice::min(self : StatsinfernonparamSlice) -> Double { @_common.min(self.data) }

pub fn StatsinfernonparamSlice::max(self : StatsinfernonparamSlice) -> Double { @_common.max(self.data) }

pub fn StatsinfernonparamSlice::to_string(self : StatsinfernonparamSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

