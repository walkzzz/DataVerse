///===
/// extcore/ml_regress_lasso

pub(all) struct MlregresslassoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_lasso_make_point(x : Double, y : Double) -> MlregresslassoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_lasso_make_point3(x : Double, y : Double, z : Double) -> MlregresslassoPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresslassoPoint::x(self : MlregresslassoPoint) -> Double { self.x }

pub fn MlregresslassoPoint::y(self : MlregresslassoPoint) -> Double { self.y }

pub fn MlregresslassoPoint::z(self : MlregresslassoPoint) -> Double { self.z }

pub fn MlregresslassoPoint::label(self : MlregresslassoPoint) -> Int { self.label }

pub fn MlregresslassoPoint::dist(self : MlregresslassoPoint, other : MlregresslassoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresslassoPoint::add(self : MlregresslassoPoint, other : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresslassoPoint::sub(self : MlregresslassoPoint, other : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresslassoPoint::scale(self : MlregresslassoPoint, s : Double) -> MlregresslassoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresslassoPoint::dot(self : MlregresslassoPoint, other : MlregresslassoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresslassoPoint::cross(self : MlregresslassoPoint, other : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresslassoPoint::norm(self : MlregresslassoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresslassoPoint::normalize(self : MlregresslassoPoint) -> MlregresslassoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslassoPoint::negate(self : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresslassoPoint::mid(self : MlregresslassoPoint, other : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresslassoPoint::lerp(self : MlregresslassoPoint, other : MlregresslassoPoint, t : Double) -> MlregresslassoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresslassoPoint::to_string(self : MlregresslassoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresslassoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_lasso_make_series(vals : Array[Double], name : String) -> MlregresslassoSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresslassoSeries::len(self : MlregresslassoSeries) -> Int { self.vals.length() }

pub fn MlregresslassoSeries::sum(self : MlregresslassoSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresslassoSeries::mean(self : MlregresslassoSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresslassoSeries::min(self : MlregresslassoSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresslassoSeries::max(self : MlregresslassoSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresslassoSeries::range(self : MlregresslassoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresslassoSeries::variance(self : MlregresslassoSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresslassoSeries::std(self : MlregresslassoSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresslassoSeries::median(self : MlregresslassoSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresslassoSeries::scale(self : MlregresslassoSeries, f : Double) -> MlregresslassoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresslassoSeries::add(self : MlregresslassoSeries, other : MlregresslassoSeries) -> MlregresslassoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresslassoSeries::sub(self : MlregresslassoSeries, other : MlregresslassoSeries) -> MlregresslassoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresslassoSeries::normalize(self : MlregresslassoSeries) -> MlregresslassoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresslassoSeries::cumsum(self : MlregresslassoSeries) -> MlregresslassoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresslassoSeries::to_string(self : MlregresslassoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslassoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_lasso_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresslassoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_lasso_matrix_identity(n : Int) -> MlregresslassoMatrix {
  let m = ml_regress_lasso_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresslassoMatrix::get(self : MlregresslassoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresslassoMatrix::transpose(self : MlregresslassoMatrix) -> MlregresslassoMatrix {
  let result = ml_regress_lasso_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresslassoMatrix::add(self : MlregresslassoMatrix, other : MlregresslassoMatrix) -> MlregresslassoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_lasso_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresslassoMatrix::scale(self : MlregresslassoMatrix, s : Double) -> MlregresslassoMatrix {
  let result = ml_regress_lasso_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresslassoMatrix::multiply(self : MlregresslassoMatrix, other : MlregresslassoMatrix) -> MlregresslassoMatrix {
  if self.cols != other.rows { return ml_regress_lasso_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_lasso_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregresslassoMatrix::trace(self : MlregresslassoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresslassoMatrix::det(self : MlregresslassoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresslassoMatrix::norm(self : MlregresslassoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresslassoMatrix::to_string(self : MlregresslassoMatrix) -> String {
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

pub(all) struct MlregresslassoVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_lasso_make_vector(comps : Array[Double]) -> MlregresslassoVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_lasso_vector_zero(dim : Int) -> MlregresslassoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresslassoVector::add(self : MlregresslassoVector, other : MlregresslassoVector) -> MlregresslassoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslassoVector::sub(self : MlregresslassoVector, other : MlregresslassoVector) -> MlregresslassoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslassoVector::scale(self : MlregresslassoVector, s : Double) -> MlregresslassoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresslassoVector::dot(self : MlregresslassoVector, other : MlregresslassoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresslassoVector::norm(self : MlregresslassoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresslassoVector::normalize(self : MlregresslassoVector) -> MlregresslassoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslassoVector::dist(self : MlregresslassoVector, other : MlregresslassoVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresslassoVector::to_string(self : MlregresslassoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslassoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_frame_make(size : Int) -> MlregresslassoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoFrame::len(self : MlregresslassoFrame) -> Int { self.size }

pub fn MlregresslassoFrame::get(self : MlregresslassoFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoFrame::set(self : MlregresslassoFrame, i : Int, v : Double) -> MlregresslassoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoFrame::sum(self : MlregresslassoFrame) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoFrame::mean(self : MlregresslassoFrame) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoFrame::scale(self : MlregresslassoFrame, f : Double) -> MlregresslassoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoFrame::add(self : MlregresslassoFrame, other : MlregresslassoFrame) -> MlregresslassoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoFrame::copy(self : MlregresslassoFrame) -> MlregresslassoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoFrame::fill(self : MlregresslassoFrame, v : Double) -> MlregresslassoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoFrame::min(self : MlregresslassoFrame) -> Double { @_common.min(self.data) }

pub fn MlregresslassoFrame::max(self : MlregresslassoFrame) -> Double { @_common.max(self.data) }

pub fn MlregresslassoFrame::to_string(self : MlregresslassoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_table_make(size : Int) -> MlregresslassoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoTable::len(self : MlregresslassoTable) -> Int { self.size }

pub fn MlregresslassoTable::get(self : MlregresslassoTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoTable::set(self : MlregresslassoTable, i : Int, v : Double) -> MlregresslassoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoTable::sum(self : MlregresslassoTable) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoTable::mean(self : MlregresslassoTable) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoTable::scale(self : MlregresslassoTable, f : Double) -> MlregresslassoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoTable::add(self : MlregresslassoTable, other : MlregresslassoTable) -> MlregresslassoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoTable::copy(self : MlregresslassoTable) -> MlregresslassoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoTable::fill(self : MlregresslassoTable, v : Double) -> MlregresslassoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoTable::min(self : MlregresslassoTable) -> Double { @_common.min(self.data) }

pub fn MlregresslassoTable::max(self : MlregresslassoTable) -> Double { @_common.max(self.data) }

pub fn MlregresslassoTable::to_string(self : MlregresslassoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_graphn_make(size : Int) -> MlregresslassoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoGraphN::len(self : MlregresslassoGraphN) -> Int { self.size }

pub fn MlregresslassoGraphN::get(self : MlregresslassoGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoGraphN::set(self : MlregresslassoGraphN, i : Int, v : Double) -> MlregresslassoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoGraphN::sum(self : MlregresslassoGraphN) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoGraphN::mean(self : MlregresslassoGraphN) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoGraphN::scale(self : MlregresslassoGraphN, f : Double) -> MlregresslassoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoGraphN::add(self : MlregresslassoGraphN, other : MlregresslassoGraphN) -> MlregresslassoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoGraphN::copy(self : MlregresslassoGraphN) -> MlregresslassoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoGraphN::fill(self : MlregresslassoGraphN, v : Double) -> MlregresslassoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoGraphN::min(self : MlregresslassoGraphN) -> Double { @_common.min(self.data) }

pub fn MlregresslassoGraphN::max(self : MlregresslassoGraphN) -> Double { @_common.max(self.data) }

pub fn MlregresslassoGraphN::to_string(self : MlregresslassoGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_node_make(size : Int) -> MlregresslassoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoNode::len(self : MlregresslassoNode) -> Int { self.size }

pub fn MlregresslassoNode::get(self : MlregresslassoNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoNode::set(self : MlregresslassoNode, i : Int, v : Double) -> MlregresslassoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoNode::sum(self : MlregresslassoNode) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoNode::mean(self : MlregresslassoNode) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoNode::scale(self : MlregresslassoNode, f : Double) -> MlregresslassoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoNode::add(self : MlregresslassoNode, other : MlregresslassoNode) -> MlregresslassoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoNode::copy(self : MlregresslassoNode) -> MlregresslassoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoNode::fill(self : MlregresslassoNode, v : Double) -> MlregresslassoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoNode::min(self : MlregresslassoNode) -> Double { @_common.min(self.data) }

pub fn MlregresslassoNode::max(self : MlregresslassoNode) -> Double { @_common.max(self.data) }

pub fn MlregresslassoNode::to_string(self : MlregresslassoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_edge_make(size : Int) -> MlregresslassoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoEdge::len(self : MlregresslassoEdge) -> Int { self.size }

pub fn MlregresslassoEdge::get(self : MlregresslassoEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoEdge::set(self : MlregresslassoEdge, i : Int, v : Double) -> MlregresslassoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoEdge::sum(self : MlregresslassoEdge) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoEdge::mean(self : MlregresslassoEdge) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoEdge::scale(self : MlregresslassoEdge, f : Double) -> MlregresslassoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoEdge::add(self : MlregresslassoEdge, other : MlregresslassoEdge) -> MlregresslassoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoEdge::copy(self : MlregresslassoEdge) -> MlregresslassoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoEdge::fill(self : MlregresslassoEdge, v : Double) -> MlregresslassoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoEdge::min(self : MlregresslassoEdge) -> Double { @_common.min(self.data) }

pub fn MlregresslassoEdge::max(self : MlregresslassoEdge) -> Double { @_common.max(self.data) }

pub fn MlregresslassoEdge::to_string(self : MlregresslassoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_path_make(size : Int) -> MlregresslassoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoPath::len(self : MlregresslassoPath) -> Int { self.size }

pub fn MlregresslassoPath::get(self : MlregresslassoPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoPath::set(self : MlregresslassoPath, i : Int, v : Double) -> MlregresslassoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoPath::sum(self : MlregresslassoPath) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoPath::mean(self : MlregresslassoPath) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoPath::scale(self : MlregresslassoPath, f : Double) -> MlregresslassoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoPath::add(self : MlregresslassoPath, other : MlregresslassoPath) -> MlregresslassoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoPath::copy(self : MlregresslassoPath) -> MlregresslassoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoPath::fill(self : MlregresslassoPath, v : Double) -> MlregresslassoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoPath::min(self : MlregresslassoPath) -> Double { @_common.min(self.data) }

pub fn MlregresslassoPath::max(self : MlregresslassoPath) -> Double { @_common.max(self.data) }

pub fn MlregresslassoPath::to_string(self : MlregresslassoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_cluster_make(size : Int) -> MlregresslassoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoCluster::len(self : MlregresslassoCluster) -> Int { self.size }

pub fn MlregresslassoCluster::get(self : MlregresslassoCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoCluster::set(self : MlregresslassoCluster, i : Int, v : Double) -> MlregresslassoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoCluster::sum(self : MlregresslassoCluster) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoCluster::mean(self : MlregresslassoCluster) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoCluster::scale(self : MlregresslassoCluster, f : Double) -> MlregresslassoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoCluster::add(self : MlregresslassoCluster, other : MlregresslassoCluster) -> MlregresslassoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoCluster::copy(self : MlregresslassoCluster) -> MlregresslassoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoCluster::fill(self : MlregresslassoCluster, v : Double) -> MlregresslassoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoCluster::min(self : MlregresslassoCluster) -> Double { @_common.min(self.data) }

pub fn MlregresslassoCluster::max(self : MlregresslassoCluster) -> Double { @_common.max(self.data) }

pub fn MlregresslassoCluster::to_string(self : MlregresslassoCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_model_make(size : Int) -> MlregresslassoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoModel::len(self : MlregresslassoModel) -> Int { self.size }

pub fn MlregresslassoModel::get(self : MlregresslassoModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoModel::set(self : MlregresslassoModel, i : Int, v : Double) -> MlregresslassoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoModel::sum(self : MlregresslassoModel) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoModel::mean(self : MlregresslassoModel) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoModel::scale(self : MlregresslassoModel, f : Double) -> MlregresslassoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoModel::add(self : MlregresslassoModel, other : MlregresslassoModel) -> MlregresslassoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoModel::copy(self : MlregresslassoModel) -> MlregresslassoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoModel::fill(self : MlregresslassoModel, v : Double) -> MlregresslassoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoModel::min(self : MlregresslassoModel) -> Double { @_common.min(self.data) }

pub fn MlregresslassoModel::max(self : MlregresslassoModel) -> Double { @_common.max(self.data) }

pub fn MlregresslassoModel::to_string(self : MlregresslassoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_layer_make(size : Int) -> MlregresslassoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoLayer::len(self : MlregresslassoLayer) -> Int { self.size }

pub fn MlregresslassoLayer::get(self : MlregresslassoLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoLayer::set(self : MlregresslassoLayer, i : Int, v : Double) -> MlregresslassoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoLayer::sum(self : MlregresslassoLayer) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoLayer::mean(self : MlregresslassoLayer) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoLayer::scale(self : MlregresslassoLayer, f : Double) -> MlregresslassoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoLayer::add(self : MlregresslassoLayer, other : MlregresslassoLayer) -> MlregresslassoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoLayer::copy(self : MlregresslassoLayer) -> MlregresslassoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoLayer::fill(self : MlregresslassoLayer, v : Double) -> MlregresslassoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoLayer::min(self : MlregresslassoLayer) -> Double { @_common.min(self.data) }

pub fn MlregresslassoLayer::max(self : MlregresslassoLayer) -> Double { @_common.max(self.data) }

pub fn MlregresslassoLayer::to_string(self : MlregresslassoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_buffer_make(size : Int) -> MlregresslassoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoBuffer::len(self : MlregresslassoBuffer) -> Int { self.size }

pub fn MlregresslassoBuffer::get(self : MlregresslassoBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoBuffer::set(self : MlregresslassoBuffer, i : Int, v : Double) -> MlregresslassoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoBuffer::sum(self : MlregresslassoBuffer) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoBuffer::mean(self : MlregresslassoBuffer) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoBuffer::scale(self : MlregresslassoBuffer, f : Double) -> MlregresslassoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoBuffer::add(self : MlregresslassoBuffer, other : MlregresslassoBuffer) -> MlregresslassoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoBuffer::copy(self : MlregresslassoBuffer) -> MlregresslassoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoBuffer::fill(self : MlregresslassoBuffer, v : Double) -> MlregresslassoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoBuffer::min(self : MlregresslassoBuffer) -> Double { @_common.min(self.data) }

pub fn MlregresslassoBuffer::max(self : MlregresslassoBuffer) -> Double { @_common.max(self.data) }

pub fn MlregresslassoBuffer::to_string(self : MlregresslassoBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_cursor_make(size : Int) -> MlregresslassoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoCursor::len(self : MlregresslassoCursor) -> Int { self.size }

pub fn MlregresslassoCursor::get(self : MlregresslassoCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoCursor::set(self : MlregresslassoCursor, i : Int, v : Double) -> MlregresslassoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoCursor::sum(self : MlregresslassoCursor) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoCursor::mean(self : MlregresslassoCursor) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoCursor::scale(self : MlregresslassoCursor, f : Double) -> MlregresslassoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoCursor::add(self : MlregresslassoCursor, other : MlregresslassoCursor) -> MlregresslassoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoCursor::copy(self : MlregresslassoCursor) -> MlregresslassoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoCursor::fill(self : MlregresslassoCursor, v : Double) -> MlregresslassoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoCursor::min(self : MlregresslassoCursor) -> Double { @_common.min(self.data) }

pub fn MlregresslassoCursor::max(self : MlregresslassoCursor) -> Double { @_common.max(self.data) }

pub fn MlregresslassoCursor::to_string(self : MlregresslassoCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_view_make(size : Int) -> MlregresslassoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoView::len(self : MlregresslassoView) -> Int { self.size }

pub fn MlregresslassoView::get(self : MlregresslassoView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoView::set(self : MlregresslassoView, i : Int, v : Double) -> MlregresslassoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoView::sum(self : MlregresslassoView) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoView::mean(self : MlregresslassoView) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoView::scale(self : MlregresslassoView, f : Double) -> MlregresslassoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoView::add(self : MlregresslassoView, other : MlregresslassoView) -> MlregresslassoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoView::copy(self : MlregresslassoView) -> MlregresslassoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoView::fill(self : MlregresslassoView, v : Double) -> MlregresslassoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoView::min(self : MlregresslassoView) -> Double { @_common.min(self.data) }

pub fn MlregresslassoView::max(self : MlregresslassoView) -> Double { @_common.max(self.data) }

pub fn MlregresslassoView::to_string(self : MlregresslassoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_range_make(size : Int) -> MlregresslassoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoRange::len(self : MlregresslassoRange) -> Int { self.size }

pub fn MlregresslassoRange::get(self : MlregresslassoRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoRange::set(self : MlregresslassoRange, i : Int, v : Double) -> MlregresslassoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoRange::sum(self : MlregresslassoRange) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoRange::mean(self : MlregresslassoRange) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoRange::scale(self : MlregresslassoRange, f : Double) -> MlregresslassoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoRange::add(self : MlregresslassoRange, other : MlregresslassoRange) -> MlregresslassoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoRange::copy(self : MlregresslassoRange) -> MlregresslassoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoRange::fill(self : MlregresslassoRange, v : Double) -> MlregresslassoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoRange::min(self : MlregresslassoRange) -> Double { @_common.min(self.data) }

pub fn MlregresslassoRange::max(self : MlregresslassoRange) -> Double { @_common.max(self.data) }

pub fn MlregresslassoRange::to_string(self : MlregresslassoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslassoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_slice_make(size : Int) -> MlregresslassoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslassoSlice::len(self : MlregresslassoSlice) -> Int { self.size }

pub fn MlregresslassoSlice::get(self : MlregresslassoSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslassoSlice::set(self : MlregresslassoSlice, i : Int, v : Double) -> MlregresslassoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslassoSlice::sum(self : MlregresslassoSlice) -> Double { @_common.sum(self.data) }

pub fn MlregresslassoSlice::mean(self : MlregresslassoSlice) -> Double { @_common.mean(self.data) }

pub fn MlregresslassoSlice::scale(self : MlregresslassoSlice, f : Double) -> MlregresslassoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslassoSlice::add(self : MlregresslassoSlice, other : MlregresslassoSlice) -> MlregresslassoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslassoSlice::copy(self : MlregresslassoSlice) -> MlregresslassoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslassoSlice::fill(self : MlregresslassoSlice, v : Double) -> MlregresslassoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslassoSlice::min(self : MlregresslassoSlice) -> Double { @_common.min(self.data) }

pub fn MlregresslassoSlice::max(self : MlregresslassoSlice) -> Double { @_common.max(self.data) }

pub fn MlregresslassoSlice::to_string(self : MlregresslassoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

