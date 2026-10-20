///===
/// extcore/ml_feature_nmf

pub(all) struct MlfeaturenmfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_nmf_make_point(x : Double, y : Double) -> MlfeaturenmfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_nmf_make_point3(x : Double, y : Double, z : Double) -> MlfeaturenmfPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturenmfPoint::x(self : MlfeaturenmfPoint) -> Double { self.x }

pub fn MlfeaturenmfPoint::y(self : MlfeaturenmfPoint) -> Double { self.y }

pub fn MlfeaturenmfPoint::z(self : MlfeaturenmfPoint) -> Double { self.z }

pub fn MlfeaturenmfPoint::label(self : MlfeaturenmfPoint) -> Int { self.label }

pub fn MlfeaturenmfPoint::dist(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturenmfPoint::add(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturenmfPoint::sub(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturenmfPoint::scale(self : MlfeaturenmfPoint, s : Double) -> MlfeaturenmfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturenmfPoint::dot(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturenmfPoint::cross(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturenmfPoint::norm(self : MlfeaturenmfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturenmfPoint::normalize(self : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturenmfPoint::negate(self : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturenmfPoint::mid(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturenmfPoint::lerp(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint, t : Double) -> MlfeaturenmfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturenmfPoint::to_string(self : MlfeaturenmfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturenmfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_nmf_make_series(vals : Array[Double], name : String) -> MlfeaturenmfSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturenmfSeries::len(self : MlfeaturenmfSeries) -> Int { self.vals.length() }

pub fn MlfeaturenmfSeries::sum(self : MlfeaturenmfSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturenmfSeries::mean(self : MlfeaturenmfSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturenmfSeries::min(self : MlfeaturenmfSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturenmfSeries::max(self : MlfeaturenmfSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturenmfSeries::range(self : MlfeaturenmfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturenmfSeries::variance(self : MlfeaturenmfSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturenmfSeries::std(self : MlfeaturenmfSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturenmfSeries::median(self : MlfeaturenmfSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturenmfSeries::scale(self : MlfeaturenmfSeries, f : Double) -> MlfeaturenmfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturenmfSeries::add(self : MlfeaturenmfSeries, other : MlfeaturenmfSeries) -> MlfeaturenmfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturenmfSeries::sub(self : MlfeaturenmfSeries, other : MlfeaturenmfSeries) -> MlfeaturenmfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturenmfSeries::normalize(self : MlfeaturenmfSeries) -> MlfeaturenmfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturenmfSeries::cumsum(self : MlfeaturenmfSeries) -> MlfeaturenmfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturenmfSeries::to_string(self : MlfeaturenmfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturenmfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_nmf_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturenmfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_nmf_matrix_identity(n : Int) -> MlfeaturenmfMatrix {
  let m = ml_feature_nmf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturenmfMatrix::get(self : MlfeaturenmfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturenmfMatrix::transpose(self : MlfeaturenmfMatrix) -> MlfeaturenmfMatrix {
  let result = ml_feature_nmf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturenmfMatrix::add(self : MlfeaturenmfMatrix, other : MlfeaturenmfMatrix) -> MlfeaturenmfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_nmf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturenmfMatrix::scale(self : MlfeaturenmfMatrix, s : Double) -> MlfeaturenmfMatrix {
  let result = ml_feature_nmf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturenmfMatrix::multiply(self : MlfeaturenmfMatrix, other : MlfeaturenmfMatrix) -> MlfeaturenmfMatrix {
  if self.cols != other.rows { return ml_feature_nmf_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_nmf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeaturenmfMatrix::trace(self : MlfeaturenmfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturenmfMatrix::det(self : MlfeaturenmfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturenmfMatrix::norm(self : MlfeaturenmfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturenmfMatrix::to_string(self : MlfeaturenmfMatrix) -> String {
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

pub(all) struct MlfeaturenmfVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_nmf_make_vector(comps : Array[Double]) -> MlfeaturenmfVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_nmf_vector_zero(dim : Int) -> MlfeaturenmfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturenmfVector::add(self : MlfeaturenmfVector, other : MlfeaturenmfVector) -> MlfeaturenmfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturenmfVector::sub(self : MlfeaturenmfVector, other : MlfeaturenmfVector) -> MlfeaturenmfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturenmfVector::scale(self : MlfeaturenmfVector, s : Double) -> MlfeaturenmfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturenmfVector::dot(self : MlfeaturenmfVector, other : MlfeaturenmfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturenmfVector::norm(self : MlfeaturenmfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturenmfVector::normalize(self : MlfeaturenmfVector) -> MlfeaturenmfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturenmfVector::dist(self : MlfeaturenmfVector, other : MlfeaturenmfVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturenmfVector::to_string(self : MlfeaturenmfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturenmfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_frame_make(size : Int) -> MlfeaturenmfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfFrame::len(self : MlfeaturenmfFrame) -> Int { self.size }

pub fn MlfeaturenmfFrame::get(self : MlfeaturenmfFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfFrame::set(self : MlfeaturenmfFrame, i : Int, v : Double) -> MlfeaturenmfFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfFrame::sum(self : MlfeaturenmfFrame) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfFrame::mean(self : MlfeaturenmfFrame) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfFrame::scale(self : MlfeaturenmfFrame, f : Double) -> MlfeaturenmfFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfFrame::add(self : MlfeaturenmfFrame, other : MlfeaturenmfFrame) -> MlfeaturenmfFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfFrame::copy(self : MlfeaturenmfFrame) -> MlfeaturenmfFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfFrame::fill(self : MlfeaturenmfFrame, v : Double) -> MlfeaturenmfFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfFrame::min(self : MlfeaturenmfFrame) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfFrame::max(self : MlfeaturenmfFrame) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfFrame::to_string(self : MlfeaturenmfFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_table_make(size : Int) -> MlfeaturenmfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfTable::len(self : MlfeaturenmfTable) -> Int { self.size }

pub fn MlfeaturenmfTable::get(self : MlfeaturenmfTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfTable::set(self : MlfeaturenmfTable, i : Int, v : Double) -> MlfeaturenmfTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfTable::sum(self : MlfeaturenmfTable) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfTable::mean(self : MlfeaturenmfTable) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfTable::scale(self : MlfeaturenmfTable, f : Double) -> MlfeaturenmfTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfTable::add(self : MlfeaturenmfTable, other : MlfeaturenmfTable) -> MlfeaturenmfTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfTable::copy(self : MlfeaturenmfTable) -> MlfeaturenmfTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfTable::fill(self : MlfeaturenmfTable, v : Double) -> MlfeaturenmfTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfTable::min(self : MlfeaturenmfTable) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfTable::max(self : MlfeaturenmfTable) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfTable::to_string(self : MlfeaturenmfTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_graphn_make(size : Int) -> MlfeaturenmfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfGraphN::len(self : MlfeaturenmfGraphN) -> Int { self.size }

pub fn MlfeaturenmfGraphN::get(self : MlfeaturenmfGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfGraphN::set(self : MlfeaturenmfGraphN, i : Int, v : Double) -> MlfeaturenmfGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfGraphN::sum(self : MlfeaturenmfGraphN) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfGraphN::mean(self : MlfeaturenmfGraphN) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfGraphN::scale(self : MlfeaturenmfGraphN, f : Double) -> MlfeaturenmfGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfGraphN::add(self : MlfeaturenmfGraphN, other : MlfeaturenmfGraphN) -> MlfeaturenmfGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfGraphN::copy(self : MlfeaturenmfGraphN) -> MlfeaturenmfGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfGraphN::fill(self : MlfeaturenmfGraphN, v : Double) -> MlfeaturenmfGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfGraphN::min(self : MlfeaturenmfGraphN) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfGraphN::max(self : MlfeaturenmfGraphN) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfGraphN::to_string(self : MlfeaturenmfGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_node_make(size : Int) -> MlfeaturenmfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfNode::len(self : MlfeaturenmfNode) -> Int { self.size }

pub fn MlfeaturenmfNode::get(self : MlfeaturenmfNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfNode::set(self : MlfeaturenmfNode, i : Int, v : Double) -> MlfeaturenmfNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfNode::sum(self : MlfeaturenmfNode) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfNode::mean(self : MlfeaturenmfNode) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfNode::scale(self : MlfeaturenmfNode, f : Double) -> MlfeaturenmfNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfNode::add(self : MlfeaturenmfNode, other : MlfeaturenmfNode) -> MlfeaturenmfNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfNode::copy(self : MlfeaturenmfNode) -> MlfeaturenmfNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfNode::fill(self : MlfeaturenmfNode, v : Double) -> MlfeaturenmfNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfNode::min(self : MlfeaturenmfNode) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfNode::max(self : MlfeaturenmfNode) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfNode::to_string(self : MlfeaturenmfNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_edge_make(size : Int) -> MlfeaturenmfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfEdge::len(self : MlfeaturenmfEdge) -> Int { self.size }

pub fn MlfeaturenmfEdge::get(self : MlfeaturenmfEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfEdge::set(self : MlfeaturenmfEdge, i : Int, v : Double) -> MlfeaturenmfEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfEdge::sum(self : MlfeaturenmfEdge) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfEdge::mean(self : MlfeaturenmfEdge) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfEdge::scale(self : MlfeaturenmfEdge, f : Double) -> MlfeaturenmfEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfEdge::add(self : MlfeaturenmfEdge, other : MlfeaturenmfEdge) -> MlfeaturenmfEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfEdge::copy(self : MlfeaturenmfEdge) -> MlfeaturenmfEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfEdge::fill(self : MlfeaturenmfEdge, v : Double) -> MlfeaturenmfEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfEdge::min(self : MlfeaturenmfEdge) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfEdge::max(self : MlfeaturenmfEdge) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfEdge::to_string(self : MlfeaturenmfEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_path_make(size : Int) -> MlfeaturenmfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfPath::len(self : MlfeaturenmfPath) -> Int { self.size }

pub fn MlfeaturenmfPath::get(self : MlfeaturenmfPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfPath::set(self : MlfeaturenmfPath, i : Int, v : Double) -> MlfeaturenmfPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfPath::sum(self : MlfeaturenmfPath) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfPath::mean(self : MlfeaturenmfPath) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfPath::scale(self : MlfeaturenmfPath, f : Double) -> MlfeaturenmfPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfPath::add(self : MlfeaturenmfPath, other : MlfeaturenmfPath) -> MlfeaturenmfPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfPath::copy(self : MlfeaturenmfPath) -> MlfeaturenmfPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfPath::fill(self : MlfeaturenmfPath, v : Double) -> MlfeaturenmfPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfPath::min(self : MlfeaturenmfPath) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfPath::max(self : MlfeaturenmfPath) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfPath::to_string(self : MlfeaturenmfPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_cluster_make(size : Int) -> MlfeaturenmfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfCluster::len(self : MlfeaturenmfCluster) -> Int { self.size }

pub fn MlfeaturenmfCluster::get(self : MlfeaturenmfCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfCluster::set(self : MlfeaturenmfCluster, i : Int, v : Double) -> MlfeaturenmfCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfCluster::sum(self : MlfeaturenmfCluster) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfCluster::mean(self : MlfeaturenmfCluster) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfCluster::scale(self : MlfeaturenmfCluster, f : Double) -> MlfeaturenmfCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfCluster::add(self : MlfeaturenmfCluster, other : MlfeaturenmfCluster) -> MlfeaturenmfCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfCluster::copy(self : MlfeaturenmfCluster) -> MlfeaturenmfCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfCluster::fill(self : MlfeaturenmfCluster, v : Double) -> MlfeaturenmfCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfCluster::min(self : MlfeaturenmfCluster) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfCluster::max(self : MlfeaturenmfCluster) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfCluster::to_string(self : MlfeaturenmfCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_model_make(size : Int) -> MlfeaturenmfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfModel::len(self : MlfeaturenmfModel) -> Int { self.size }

pub fn MlfeaturenmfModel::get(self : MlfeaturenmfModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfModel::set(self : MlfeaturenmfModel, i : Int, v : Double) -> MlfeaturenmfModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfModel::sum(self : MlfeaturenmfModel) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfModel::mean(self : MlfeaturenmfModel) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfModel::scale(self : MlfeaturenmfModel, f : Double) -> MlfeaturenmfModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfModel::add(self : MlfeaturenmfModel, other : MlfeaturenmfModel) -> MlfeaturenmfModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfModel::copy(self : MlfeaturenmfModel) -> MlfeaturenmfModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfModel::fill(self : MlfeaturenmfModel, v : Double) -> MlfeaturenmfModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfModel::min(self : MlfeaturenmfModel) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfModel::max(self : MlfeaturenmfModel) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfModel::to_string(self : MlfeaturenmfModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_layer_make(size : Int) -> MlfeaturenmfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfLayer::len(self : MlfeaturenmfLayer) -> Int { self.size }

pub fn MlfeaturenmfLayer::get(self : MlfeaturenmfLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfLayer::set(self : MlfeaturenmfLayer, i : Int, v : Double) -> MlfeaturenmfLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfLayer::sum(self : MlfeaturenmfLayer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfLayer::mean(self : MlfeaturenmfLayer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfLayer::scale(self : MlfeaturenmfLayer, f : Double) -> MlfeaturenmfLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfLayer::add(self : MlfeaturenmfLayer, other : MlfeaturenmfLayer) -> MlfeaturenmfLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfLayer::copy(self : MlfeaturenmfLayer) -> MlfeaturenmfLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfLayer::fill(self : MlfeaturenmfLayer, v : Double) -> MlfeaturenmfLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfLayer::min(self : MlfeaturenmfLayer) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfLayer::max(self : MlfeaturenmfLayer) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfLayer::to_string(self : MlfeaturenmfLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_buffer_make(size : Int) -> MlfeaturenmfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfBuffer::len(self : MlfeaturenmfBuffer) -> Int { self.size }

pub fn MlfeaturenmfBuffer::get(self : MlfeaturenmfBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfBuffer::set(self : MlfeaturenmfBuffer, i : Int, v : Double) -> MlfeaturenmfBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfBuffer::sum(self : MlfeaturenmfBuffer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfBuffer::mean(self : MlfeaturenmfBuffer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfBuffer::scale(self : MlfeaturenmfBuffer, f : Double) -> MlfeaturenmfBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfBuffer::add(self : MlfeaturenmfBuffer, other : MlfeaturenmfBuffer) -> MlfeaturenmfBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfBuffer::copy(self : MlfeaturenmfBuffer) -> MlfeaturenmfBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfBuffer::fill(self : MlfeaturenmfBuffer, v : Double) -> MlfeaturenmfBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfBuffer::min(self : MlfeaturenmfBuffer) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfBuffer::max(self : MlfeaturenmfBuffer) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfBuffer::to_string(self : MlfeaturenmfBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_cursor_make(size : Int) -> MlfeaturenmfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfCursor::len(self : MlfeaturenmfCursor) -> Int { self.size }

pub fn MlfeaturenmfCursor::get(self : MlfeaturenmfCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfCursor::set(self : MlfeaturenmfCursor, i : Int, v : Double) -> MlfeaturenmfCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfCursor::sum(self : MlfeaturenmfCursor) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfCursor::mean(self : MlfeaturenmfCursor) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfCursor::scale(self : MlfeaturenmfCursor, f : Double) -> MlfeaturenmfCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfCursor::add(self : MlfeaturenmfCursor, other : MlfeaturenmfCursor) -> MlfeaturenmfCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfCursor::copy(self : MlfeaturenmfCursor) -> MlfeaturenmfCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfCursor::fill(self : MlfeaturenmfCursor, v : Double) -> MlfeaturenmfCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfCursor::min(self : MlfeaturenmfCursor) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfCursor::max(self : MlfeaturenmfCursor) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfCursor::to_string(self : MlfeaturenmfCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_view_make(size : Int) -> MlfeaturenmfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfView::len(self : MlfeaturenmfView) -> Int { self.size }

pub fn MlfeaturenmfView::get(self : MlfeaturenmfView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfView::set(self : MlfeaturenmfView, i : Int, v : Double) -> MlfeaturenmfView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfView::sum(self : MlfeaturenmfView) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfView::mean(self : MlfeaturenmfView) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfView::scale(self : MlfeaturenmfView, f : Double) -> MlfeaturenmfView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfView::add(self : MlfeaturenmfView, other : MlfeaturenmfView) -> MlfeaturenmfView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfView::copy(self : MlfeaturenmfView) -> MlfeaturenmfView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfView::fill(self : MlfeaturenmfView, v : Double) -> MlfeaturenmfView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfView::min(self : MlfeaturenmfView) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfView::max(self : MlfeaturenmfView) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfView::to_string(self : MlfeaturenmfView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_range_make(size : Int) -> MlfeaturenmfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfRange::len(self : MlfeaturenmfRange) -> Int { self.size }

pub fn MlfeaturenmfRange::get(self : MlfeaturenmfRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfRange::set(self : MlfeaturenmfRange, i : Int, v : Double) -> MlfeaturenmfRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfRange::sum(self : MlfeaturenmfRange) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfRange::mean(self : MlfeaturenmfRange) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfRange::scale(self : MlfeaturenmfRange, f : Double) -> MlfeaturenmfRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfRange::add(self : MlfeaturenmfRange, other : MlfeaturenmfRange) -> MlfeaturenmfRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfRange::copy(self : MlfeaturenmfRange) -> MlfeaturenmfRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfRange::fill(self : MlfeaturenmfRange, v : Double) -> MlfeaturenmfRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfRange::min(self : MlfeaturenmfRange) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfRange::max(self : MlfeaturenmfRange) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfRange::to_string(self : MlfeaturenmfRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_slice_make(size : Int) -> MlfeaturenmfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturenmfSlice::len(self : MlfeaturenmfSlice) -> Int { self.size }

pub fn MlfeaturenmfSlice::get(self : MlfeaturenmfSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturenmfSlice::set(self : MlfeaturenmfSlice, i : Int, v : Double) -> MlfeaturenmfSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfSlice::sum(self : MlfeaturenmfSlice) -> Double { @_common.sum(self.data) }

pub fn MlfeaturenmfSlice::mean(self : MlfeaturenmfSlice) -> Double { @_common.mean(self.data) }

pub fn MlfeaturenmfSlice::scale(self : MlfeaturenmfSlice, f : Double) -> MlfeaturenmfSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfSlice::add(self : MlfeaturenmfSlice, other : MlfeaturenmfSlice) -> MlfeaturenmfSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturenmfSlice::copy(self : MlfeaturenmfSlice) -> MlfeaturenmfSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfSlice::fill(self : MlfeaturenmfSlice, v : Double) -> MlfeaturenmfSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturenmfSlice::min(self : MlfeaturenmfSlice) -> Double { @_common.min(self.data) }

pub fn MlfeaturenmfSlice::max(self : MlfeaturenmfSlice) -> Double { @_common.max(self.data) }

pub fn MlfeaturenmfSlice::to_string(self : MlfeaturenmfSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

