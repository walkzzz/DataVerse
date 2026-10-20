///===
/// extcore/ml_metric_fairness

pub(all) struct MlmetricfairnessPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_fairness_make_point(x : Double, y : Double) -> MlmetricfairnessPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_fairness_make_point3(x : Double, y : Double, z : Double) -> MlmetricfairnessPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricfairnessPoint::x(self : MlmetricfairnessPoint) -> Double { self.x }

pub fn MlmetricfairnessPoint::y(self : MlmetricfairnessPoint) -> Double { self.y }

pub fn MlmetricfairnessPoint::z(self : MlmetricfairnessPoint) -> Double { self.z }

pub fn MlmetricfairnessPoint::label(self : MlmetricfairnessPoint) -> Int { self.label }

pub fn MlmetricfairnessPoint::dist(self : MlmetricfairnessPoint, other : MlmetricfairnessPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricfairnessPoint::add(self : MlmetricfairnessPoint, other : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricfairnessPoint::sub(self : MlmetricfairnessPoint, other : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricfairnessPoint::scale(self : MlmetricfairnessPoint, s : Double) -> MlmetricfairnessPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricfairnessPoint::dot(self : MlmetricfairnessPoint, other : MlmetricfairnessPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricfairnessPoint::cross(self : MlmetricfairnessPoint, other : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricfairnessPoint::norm(self : MlmetricfairnessPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricfairnessPoint::normalize(self : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricfairnessPoint::negate(self : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricfairnessPoint::mid(self : MlmetricfairnessPoint, other : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricfairnessPoint::lerp(self : MlmetricfairnessPoint, other : MlmetricfairnessPoint, t : Double) -> MlmetricfairnessPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricfairnessPoint::to_string(self : MlmetricfairnessPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricfairnessSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_fairness_make_series(vals : Array[Double], name : String) -> MlmetricfairnessSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricfairnessSeries::len(self : MlmetricfairnessSeries) -> Int { self.vals.length() }

pub fn MlmetricfairnessSeries::sum(self : MlmetricfairnessSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricfairnessSeries::mean(self : MlmetricfairnessSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricfairnessSeries::min(self : MlmetricfairnessSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricfairnessSeries::max(self : MlmetricfairnessSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricfairnessSeries::range(self : MlmetricfairnessSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricfairnessSeries::variance(self : MlmetricfairnessSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricfairnessSeries::std(self : MlmetricfairnessSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricfairnessSeries::median(self : MlmetricfairnessSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricfairnessSeries::scale(self : MlmetricfairnessSeries, f : Double) -> MlmetricfairnessSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricfairnessSeries::add(self : MlmetricfairnessSeries, other : MlmetricfairnessSeries) -> MlmetricfairnessSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricfairnessSeries::sub(self : MlmetricfairnessSeries, other : MlmetricfairnessSeries) -> MlmetricfairnessSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricfairnessSeries::normalize(self : MlmetricfairnessSeries) -> MlmetricfairnessSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricfairnessSeries::cumsum(self : MlmetricfairnessSeries) -> MlmetricfairnessSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricfairnessSeries::to_string(self : MlmetricfairnessSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricfairnessMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_fairness_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricfairnessMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_fairness_matrix_identity(n : Int) -> MlmetricfairnessMatrix {
  let m = ml_metric_fairness_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricfairnessMatrix::get(self : MlmetricfairnessMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricfairnessMatrix::transpose(self : MlmetricfairnessMatrix) -> MlmetricfairnessMatrix {
  let result = ml_metric_fairness_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricfairnessMatrix::add(self : MlmetricfairnessMatrix, other : MlmetricfairnessMatrix) -> MlmetricfairnessMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_fairness_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricfairnessMatrix::scale(self : MlmetricfairnessMatrix, s : Double) -> MlmetricfairnessMatrix {
  let result = ml_metric_fairness_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricfairnessMatrix::multiply(self : MlmetricfairnessMatrix, other : MlmetricfairnessMatrix) -> MlmetricfairnessMatrix {
  if self.cols != other.rows { return ml_metric_fairness_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_fairness_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricfairnessMatrix::trace(self : MlmetricfairnessMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricfairnessMatrix::det(self : MlmetricfairnessMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricfairnessMatrix::norm(self : MlmetricfairnessMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricfairnessMatrix::to_string(self : MlmetricfairnessMatrix) -> String {
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

pub(all) struct MlmetricfairnessVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_fairness_make_vector(comps : Array[Double]) -> MlmetricfairnessVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_fairness_vector_zero(dim : Int) -> MlmetricfairnessVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricfairnessVector::add(self : MlmetricfairnessVector, other : MlmetricfairnessVector) -> MlmetricfairnessVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricfairnessVector::sub(self : MlmetricfairnessVector, other : MlmetricfairnessVector) -> MlmetricfairnessVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricfairnessVector::scale(self : MlmetricfairnessVector, s : Double) -> MlmetricfairnessVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricfairnessVector::dot(self : MlmetricfairnessVector, other : MlmetricfairnessVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricfairnessVector::norm(self : MlmetricfairnessVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricfairnessVector::normalize(self : MlmetricfairnessVector) -> MlmetricfairnessVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricfairnessVector::dist(self : MlmetricfairnessVector, other : MlmetricfairnessVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricfairnessVector::to_string(self : MlmetricfairnessVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricfairnessFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_frame_make(size : Int) -> MlmetricfairnessFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessFrame::len(self : MlmetricfairnessFrame) -> Int { self.size }

pub fn MlmetricfairnessFrame::get(self : MlmetricfairnessFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessFrame::set(self : MlmetricfairnessFrame, i : Int, v : Double) -> MlmetricfairnessFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessFrame::sum(self : MlmetricfairnessFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessFrame::mean(self : MlmetricfairnessFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessFrame::scale(self : MlmetricfairnessFrame, f : Double) -> MlmetricfairnessFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessFrame::add(self : MlmetricfairnessFrame, other : MlmetricfairnessFrame) -> MlmetricfairnessFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessFrame::copy(self : MlmetricfairnessFrame) -> MlmetricfairnessFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessFrame::fill(self : MlmetricfairnessFrame, v : Double) -> MlmetricfairnessFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessFrame::min(self : MlmetricfairnessFrame) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessFrame::max(self : MlmetricfairnessFrame) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessFrame::to_string(self : MlmetricfairnessFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_table_make(size : Int) -> MlmetricfairnessTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessTable::len(self : MlmetricfairnessTable) -> Int { self.size }

pub fn MlmetricfairnessTable::get(self : MlmetricfairnessTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessTable::set(self : MlmetricfairnessTable, i : Int, v : Double) -> MlmetricfairnessTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessTable::sum(self : MlmetricfairnessTable) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessTable::mean(self : MlmetricfairnessTable) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessTable::scale(self : MlmetricfairnessTable, f : Double) -> MlmetricfairnessTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessTable::add(self : MlmetricfairnessTable, other : MlmetricfairnessTable) -> MlmetricfairnessTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessTable::copy(self : MlmetricfairnessTable) -> MlmetricfairnessTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessTable::fill(self : MlmetricfairnessTable, v : Double) -> MlmetricfairnessTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessTable::min(self : MlmetricfairnessTable) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessTable::max(self : MlmetricfairnessTable) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessTable::to_string(self : MlmetricfairnessTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_graphn_make(size : Int) -> MlmetricfairnessGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessGraphN::len(self : MlmetricfairnessGraphN) -> Int { self.size }

pub fn MlmetricfairnessGraphN::get(self : MlmetricfairnessGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessGraphN::set(self : MlmetricfairnessGraphN, i : Int, v : Double) -> MlmetricfairnessGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessGraphN::sum(self : MlmetricfairnessGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessGraphN::mean(self : MlmetricfairnessGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessGraphN::scale(self : MlmetricfairnessGraphN, f : Double) -> MlmetricfairnessGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessGraphN::add(self : MlmetricfairnessGraphN, other : MlmetricfairnessGraphN) -> MlmetricfairnessGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessGraphN::copy(self : MlmetricfairnessGraphN) -> MlmetricfairnessGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessGraphN::fill(self : MlmetricfairnessGraphN, v : Double) -> MlmetricfairnessGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessGraphN::min(self : MlmetricfairnessGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessGraphN::max(self : MlmetricfairnessGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessGraphN::to_string(self : MlmetricfairnessGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_node_make(size : Int) -> MlmetricfairnessNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessNode::len(self : MlmetricfairnessNode) -> Int { self.size }

pub fn MlmetricfairnessNode::get(self : MlmetricfairnessNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessNode::set(self : MlmetricfairnessNode, i : Int, v : Double) -> MlmetricfairnessNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessNode::sum(self : MlmetricfairnessNode) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessNode::mean(self : MlmetricfairnessNode) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessNode::scale(self : MlmetricfairnessNode, f : Double) -> MlmetricfairnessNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessNode::add(self : MlmetricfairnessNode, other : MlmetricfairnessNode) -> MlmetricfairnessNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessNode::copy(self : MlmetricfairnessNode) -> MlmetricfairnessNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessNode::fill(self : MlmetricfairnessNode, v : Double) -> MlmetricfairnessNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessNode::min(self : MlmetricfairnessNode) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessNode::max(self : MlmetricfairnessNode) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessNode::to_string(self : MlmetricfairnessNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_edge_make(size : Int) -> MlmetricfairnessEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessEdge::len(self : MlmetricfairnessEdge) -> Int { self.size }

pub fn MlmetricfairnessEdge::get(self : MlmetricfairnessEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessEdge::set(self : MlmetricfairnessEdge, i : Int, v : Double) -> MlmetricfairnessEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessEdge::sum(self : MlmetricfairnessEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessEdge::mean(self : MlmetricfairnessEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessEdge::scale(self : MlmetricfairnessEdge, f : Double) -> MlmetricfairnessEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessEdge::add(self : MlmetricfairnessEdge, other : MlmetricfairnessEdge) -> MlmetricfairnessEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessEdge::copy(self : MlmetricfairnessEdge) -> MlmetricfairnessEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessEdge::fill(self : MlmetricfairnessEdge, v : Double) -> MlmetricfairnessEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessEdge::min(self : MlmetricfairnessEdge) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessEdge::max(self : MlmetricfairnessEdge) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessEdge::to_string(self : MlmetricfairnessEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_path_make(size : Int) -> MlmetricfairnessPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessPath::len(self : MlmetricfairnessPath) -> Int { self.size }

pub fn MlmetricfairnessPath::get(self : MlmetricfairnessPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessPath::set(self : MlmetricfairnessPath, i : Int, v : Double) -> MlmetricfairnessPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessPath::sum(self : MlmetricfairnessPath) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessPath::mean(self : MlmetricfairnessPath) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessPath::scale(self : MlmetricfairnessPath, f : Double) -> MlmetricfairnessPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessPath::add(self : MlmetricfairnessPath, other : MlmetricfairnessPath) -> MlmetricfairnessPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessPath::copy(self : MlmetricfairnessPath) -> MlmetricfairnessPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessPath::fill(self : MlmetricfairnessPath, v : Double) -> MlmetricfairnessPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessPath::min(self : MlmetricfairnessPath) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessPath::max(self : MlmetricfairnessPath) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessPath::to_string(self : MlmetricfairnessPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_cluster_make(size : Int) -> MlmetricfairnessCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessCluster::len(self : MlmetricfairnessCluster) -> Int { self.size }

pub fn MlmetricfairnessCluster::get(self : MlmetricfairnessCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessCluster::set(self : MlmetricfairnessCluster, i : Int, v : Double) -> MlmetricfairnessCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessCluster::sum(self : MlmetricfairnessCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessCluster::mean(self : MlmetricfairnessCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessCluster::scale(self : MlmetricfairnessCluster, f : Double) -> MlmetricfairnessCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessCluster::add(self : MlmetricfairnessCluster, other : MlmetricfairnessCluster) -> MlmetricfairnessCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessCluster::copy(self : MlmetricfairnessCluster) -> MlmetricfairnessCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessCluster::fill(self : MlmetricfairnessCluster, v : Double) -> MlmetricfairnessCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessCluster::min(self : MlmetricfairnessCluster) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessCluster::max(self : MlmetricfairnessCluster) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessCluster::to_string(self : MlmetricfairnessCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_model_make(size : Int) -> MlmetricfairnessModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessModel::len(self : MlmetricfairnessModel) -> Int { self.size }

pub fn MlmetricfairnessModel::get(self : MlmetricfairnessModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessModel::set(self : MlmetricfairnessModel, i : Int, v : Double) -> MlmetricfairnessModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessModel::sum(self : MlmetricfairnessModel) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessModel::mean(self : MlmetricfairnessModel) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessModel::scale(self : MlmetricfairnessModel, f : Double) -> MlmetricfairnessModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessModel::add(self : MlmetricfairnessModel, other : MlmetricfairnessModel) -> MlmetricfairnessModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessModel::copy(self : MlmetricfairnessModel) -> MlmetricfairnessModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessModel::fill(self : MlmetricfairnessModel, v : Double) -> MlmetricfairnessModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessModel::min(self : MlmetricfairnessModel) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessModel::max(self : MlmetricfairnessModel) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessModel::to_string(self : MlmetricfairnessModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_layer_make(size : Int) -> MlmetricfairnessLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessLayer::len(self : MlmetricfairnessLayer) -> Int { self.size }

pub fn MlmetricfairnessLayer::get(self : MlmetricfairnessLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessLayer::set(self : MlmetricfairnessLayer, i : Int, v : Double) -> MlmetricfairnessLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessLayer::sum(self : MlmetricfairnessLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessLayer::mean(self : MlmetricfairnessLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessLayer::scale(self : MlmetricfairnessLayer, f : Double) -> MlmetricfairnessLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessLayer::add(self : MlmetricfairnessLayer, other : MlmetricfairnessLayer) -> MlmetricfairnessLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessLayer::copy(self : MlmetricfairnessLayer) -> MlmetricfairnessLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessLayer::fill(self : MlmetricfairnessLayer, v : Double) -> MlmetricfairnessLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessLayer::min(self : MlmetricfairnessLayer) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessLayer::max(self : MlmetricfairnessLayer) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessLayer::to_string(self : MlmetricfairnessLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_buffer_make(size : Int) -> MlmetricfairnessBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessBuffer::len(self : MlmetricfairnessBuffer) -> Int { self.size }

pub fn MlmetricfairnessBuffer::get(self : MlmetricfairnessBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessBuffer::set(self : MlmetricfairnessBuffer, i : Int, v : Double) -> MlmetricfairnessBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessBuffer::sum(self : MlmetricfairnessBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessBuffer::mean(self : MlmetricfairnessBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessBuffer::scale(self : MlmetricfairnessBuffer, f : Double) -> MlmetricfairnessBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessBuffer::add(self : MlmetricfairnessBuffer, other : MlmetricfairnessBuffer) -> MlmetricfairnessBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessBuffer::copy(self : MlmetricfairnessBuffer) -> MlmetricfairnessBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessBuffer::fill(self : MlmetricfairnessBuffer, v : Double) -> MlmetricfairnessBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessBuffer::min(self : MlmetricfairnessBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessBuffer::max(self : MlmetricfairnessBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessBuffer::to_string(self : MlmetricfairnessBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_cursor_make(size : Int) -> MlmetricfairnessCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessCursor::len(self : MlmetricfairnessCursor) -> Int { self.size }

pub fn MlmetricfairnessCursor::get(self : MlmetricfairnessCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessCursor::set(self : MlmetricfairnessCursor, i : Int, v : Double) -> MlmetricfairnessCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessCursor::sum(self : MlmetricfairnessCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessCursor::mean(self : MlmetricfairnessCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessCursor::scale(self : MlmetricfairnessCursor, f : Double) -> MlmetricfairnessCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessCursor::add(self : MlmetricfairnessCursor, other : MlmetricfairnessCursor) -> MlmetricfairnessCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessCursor::copy(self : MlmetricfairnessCursor) -> MlmetricfairnessCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessCursor::fill(self : MlmetricfairnessCursor, v : Double) -> MlmetricfairnessCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessCursor::min(self : MlmetricfairnessCursor) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessCursor::max(self : MlmetricfairnessCursor) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessCursor::to_string(self : MlmetricfairnessCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_view_make(size : Int) -> MlmetricfairnessView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessView::len(self : MlmetricfairnessView) -> Int { self.size }

pub fn MlmetricfairnessView::get(self : MlmetricfairnessView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessView::set(self : MlmetricfairnessView, i : Int, v : Double) -> MlmetricfairnessView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessView::sum(self : MlmetricfairnessView) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessView::mean(self : MlmetricfairnessView) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessView::scale(self : MlmetricfairnessView, f : Double) -> MlmetricfairnessView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessView::add(self : MlmetricfairnessView, other : MlmetricfairnessView) -> MlmetricfairnessView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessView::copy(self : MlmetricfairnessView) -> MlmetricfairnessView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessView::fill(self : MlmetricfairnessView, v : Double) -> MlmetricfairnessView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessView::min(self : MlmetricfairnessView) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessView::max(self : MlmetricfairnessView) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessView::to_string(self : MlmetricfairnessView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_range_make(size : Int) -> MlmetricfairnessRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessRange::len(self : MlmetricfairnessRange) -> Int { self.size }

pub fn MlmetricfairnessRange::get(self : MlmetricfairnessRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessRange::set(self : MlmetricfairnessRange, i : Int, v : Double) -> MlmetricfairnessRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessRange::sum(self : MlmetricfairnessRange) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessRange::mean(self : MlmetricfairnessRange) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessRange::scale(self : MlmetricfairnessRange, f : Double) -> MlmetricfairnessRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessRange::add(self : MlmetricfairnessRange, other : MlmetricfairnessRange) -> MlmetricfairnessRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessRange::copy(self : MlmetricfairnessRange) -> MlmetricfairnessRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessRange::fill(self : MlmetricfairnessRange, v : Double) -> MlmetricfairnessRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessRange::min(self : MlmetricfairnessRange) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessRange::max(self : MlmetricfairnessRange) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessRange::to_string(self : MlmetricfairnessRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_slice_make(size : Int) -> MlmetricfairnessSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricfairnessSlice::len(self : MlmetricfairnessSlice) -> Int { self.size }

pub fn MlmetricfairnessSlice::get(self : MlmetricfairnessSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricfairnessSlice::set(self : MlmetricfairnessSlice, i : Int, v : Double) -> MlmetricfairnessSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessSlice::sum(self : MlmetricfairnessSlice) -> Double { @_common.sum(self.data) }

pub fn MlmetricfairnessSlice::mean(self : MlmetricfairnessSlice) -> Double { @_common.mean(self.data) }

pub fn MlmetricfairnessSlice::scale(self : MlmetricfairnessSlice, f : Double) -> MlmetricfairnessSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessSlice::add(self : MlmetricfairnessSlice, other : MlmetricfairnessSlice) -> MlmetricfairnessSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricfairnessSlice::copy(self : MlmetricfairnessSlice) -> MlmetricfairnessSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessSlice::fill(self : MlmetricfairnessSlice, v : Double) -> MlmetricfairnessSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricfairnessSlice::min(self : MlmetricfairnessSlice) -> Double { @_common.min(self.data) }

pub fn MlmetricfairnessSlice::max(self : MlmetricfairnessSlice) -> Double { @_common.max(self.data) }

pub fn MlmetricfairnessSlice::to_string(self : MlmetricfairnessSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

