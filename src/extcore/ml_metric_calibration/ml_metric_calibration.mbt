///===
/// extcore/ml_metric_calibration

pub(all) struct MlmetriccalibrationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_calibration_make_point(x : Double, y : Double) -> MlmetriccalibrationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_calibration_make_point3(x : Double, y : Double, z : Double) -> MlmetriccalibrationPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetriccalibrationPoint::x(self : MlmetriccalibrationPoint) -> Double { self.x }

pub fn MlmetriccalibrationPoint::y(self : MlmetriccalibrationPoint) -> Double { self.y }

pub fn MlmetriccalibrationPoint::z(self : MlmetriccalibrationPoint) -> Double { self.z }

pub fn MlmetriccalibrationPoint::label(self : MlmetriccalibrationPoint) -> Int { self.label }

pub fn MlmetriccalibrationPoint::dist(self : MlmetriccalibrationPoint, other : MlmetriccalibrationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetriccalibrationPoint::add(self : MlmetriccalibrationPoint, other : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetriccalibrationPoint::sub(self : MlmetriccalibrationPoint, other : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetriccalibrationPoint::scale(self : MlmetriccalibrationPoint, s : Double) -> MlmetriccalibrationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetriccalibrationPoint::dot(self : MlmetriccalibrationPoint, other : MlmetriccalibrationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetriccalibrationPoint::cross(self : MlmetriccalibrationPoint, other : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetriccalibrationPoint::norm(self : MlmetriccalibrationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetriccalibrationPoint::normalize(self : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetriccalibrationPoint::negate(self : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetriccalibrationPoint::mid(self : MlmetriccalibrationPoint, other : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetriccalibrationPoint::lerp(self : MlmetriccalibrationPoint, other : MlmetriccalibrationPoint, t : Double) -> MlmetriccalibrationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetriccalibrationPoint::to_string(self : MlmetriccalibrationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetriccalibrationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_calibration_make_series(vals : Array[Double], name : String) -> MlmetriccalibrationSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetriccalibrationSeries::len(self : MlmetriccalibrationSeries) -> Int { self.vals.length() }

pub fn MlmetriccalibrationSeries::sum(self : MlmetriccalibrationSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetriccalibrationSeries::mean(self : MlmetriccalibrationSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetriccalibrationSeries::min(self : MlmetriccalibrationSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetriccalibrationSeries::max(self : MlmetriccalibrationSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetriccalibrationSeries::range(self : MlmetriccalibrationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetriccalibrationSeries::variance(self : MlmetriccalibrationSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetriccalibrationSeries::std(self : MlmetriccalibrationSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetriccalibrationSeries::median(self : MlmetriccalibrationSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetriccalibrationSeries::scale(self : MlmetriccalibrationSeries, f : Double) -> MlmetriccalibrationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetriccalibrationSeries::add(self : MlmetriccalibrationSeries, other : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetriccalibrationSeries::sub(self : MlmetriccalibrationSeries, other : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetriccalibrationSeries::normalize(self : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetriccalibrationSeries::cumsum(self : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetriccalibrationSeries::to_string(self : MlmetriccalibrationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetriccalibrationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_calibration_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetriccalibrationMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_metric_calibration_matrix_identity(n : Int) -> MlmetriccalibrationMatrix {
  let m = ml_metric_calibration_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetriccalibrationMatrix::get(self : MlmetriccalibrationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetriccalibrationMatrix::transpose(self : MlmetriccalibrationMatrix) -> MlmetriccalibrationMatrix {
  let result = ml_metric_calibration_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetriccalibrationMatrix::add(self : MlmetriccalibrationMatrix, other : MlmetriccalibrationMatrix) -> MlmetriccalibrationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_calibration_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetriccalibrationMatrix::scale(self : MlmetriccalibrationMatrix, s : Double) -> MlmetriccalibrationMatrix {
  let result = ml_metric_calibration_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetriccalibrationMatrix::multiply(self : MlmetriccalibrationMatrix, other : MlmetriccalibrationMatrix) -> MlmetriccalibrationMatrix {
  if self.cols != other.rows { return ml_metric_calibration_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_calibration_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlmetriccalibrationMatrix::trace(self : MlmetriccalibrationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetriccalibrationMatrix::det(self : MlmetriccalibrationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetriccalibrationMatrix::norm(self : MlmetriccalibrationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetriccalibrationMatrix::to_string(self : MlmetriccalibrationMatrix) -> String {
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

pub(all) struct MlmetriccalibrationVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_calibration_make_vector(comps : Array[Double]) -> MlmetriccalibrationVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_calibration_vector_zero(dim : Int) -> MlmetriccalibrationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetriccalibrationVector::add(self : MlmetriccalibrationVector, other : MlmetriccalibrationVector) -> MlmetriccalibrationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetriccalibrationVector::sub(self : MlmetriccalibrationVector, other : MlmetriccalibrationVector) -> MlmetriccalibrationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetriccalibrationVector::scale(self : MlmetriccalibrationVector, s : Double) -> MlmetriccalibrationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetriccalibrationVector::dot(self : MlmetriccalibrationVector, other : MlmetriccalibrationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetriccalibrationVector::norm(self : MlmetriccalibrationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetriccalibrationVector::normalize(self : MlmetriccalibrationVector) -> MlmetriccalibrationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetriccalibrationVector::dist(self : MlmetriccalibrationVector, other : MlmetriccalibrationVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetriccalibrationVector::to_string(self : MlmetriccalibrationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetriccalibrationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_frame_make(size : Int) -> MlmetriccalibrationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationFrame::len(self : MlmetriccalibrationFrame) -> Int { self.size }

pub fn MlmetriccalibrationFrame::get(self : MlmetriccalibrationFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationFrame::set(self : MlmetriccalibrationFrame, i : Int, v : Double) -> MlmetriccalibrationFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationFrame::sum(self : MlmetriccalibrationFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationFrame::mean(self : MlmetriccalibrationFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationFrame::scale(self : MlmetriccalibrationFrame, f : Double) -> MlmetriccalibrationFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationFrame::add(self : MlmetriccalibrationFrame, other : MlmetriccalibrationFrame) -> MlmetriccalibrationFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationFrame::copy(self : MlmetriccalibrationFrame) -> MlmetriccalibrationFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationFrame::fill(self : MlmetriccalibrationFrame, v : Double) -> MlmetriccalibrationFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationFrame::min(self : MlmetriccalibrationFrame) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationFrame::max(self : MlmetriccalibrationFrame) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationFrame::to_string(self : MlmetriccalibrationFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_table_make(size : Int) -> MlmetriccalibrationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationTable::len(self : MlmetriccalibrationTable) -> Int { self.size }

pub fn MlmetriccalibrationTable::get(self : MlmetriccalibrationTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationTable::set(self : MlmetriccalibrationTable, i : Int, v : Double) -> MlmetriccalibrationTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationTable::sum(self : MlmetriccalibrationTable) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationTable::mean(self : MlmetriccalibrationTable) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationTable::scale(self : MlmetriccalibrationTable, f : Double) -> MlmetriccalibrationTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationTable::add(self : MlmetriccalibrationTable, other : MlmetriccalibrationTable) -> MlmetriccalibrationTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationTable::copy(self : MlmetriccalibrationTable) -> MlmetriccalibrationTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationTable::fill(self : MlmetriccalibrationTable, v : Double) -> MlmetriccalibrationTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationTable::min(self : MlmetriccalibrationTable) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationTable::max(self : MlmetriccalibrationTable) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationTable::to_string(self : MlmetriccalibrationTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_graphn_make(size : Int) -> MlmetriccalibrationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationGraphN::len(self : MlmetriccalibrationGraphN) -> Int { self.size }

pub fn MlmetriccalibrationGraphN::get(self : MlmetriccalibrationGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationGraphN::set(self : MlmetriccalibrationGraphN, i : Int, v : Double) -> MlmetriccalibrationGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationGraphN::sum(self : MlmetriccalibrationGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationGraphN::mean(self : MlmetriccalibrationGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationGraphN::scale(self : MlmetriccalibrationGraphN, f : Double) -> MlmetriccalibrationGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationGraphN::add(self : MlmetriccalibrationGraphN, other : MlmetriccalibrationGraphN) -> MlmetriccalibrationGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationGraphN::copy(self : MlmetriccalibrationGraphN) -> MlmetriccalibrationGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationGraphN::fill(self : MlmetriccalibrationGraphN, v : Double) -> MlmetriccalibrationGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationGraphN::min(self : MlmetriccalibrationGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationGraphN::max(self : MlmetriccalibrationGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationGraphN::to_string(self : MlmetriccalibrationGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_node_make(size : Int) -> MlmetriccalibrationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationNode::len(self : MlmetriccalibrationNode) -> Int { self.size }

pub fn MlmetriccalibrationNode::get(self : MlmetriccalibrationNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationNode::set(self : MlmetriccalibrationNode, i : Int, v : Double) -> MlmetriccalibrationNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationNode::sum(self : MlmetriccalibrationNode) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationNode::mean(self : MlmetriccalibrationNode) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationNode::scale(self : MlmetriccalibrationNode, f : Double) -> MlmetriccalibrationNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationNode::add(self : MlmetriccalibrationNode, other : MlmetriccalibrationNode) -> MlmetriccalibrationNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationNode::copy(self : MlmetriccalibrationNode) -> MlmetriccalibrationNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationNode::fill(self : MlmetriccalibrationNode, v : Double) -> MlmetriccalibrationNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationNode::min(self : MlmetriccalibrationNode) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationNode::max(self : MlmetriccalibrationNode) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationNode::to_string(self : MlmetriccalibrationNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_edge_make(size : Int) -> MlmetriccalibrationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationEdge::len(self : MlmetriccalibrationEdge) -> Int { self.size }

pub fn MlmetriccalibrationEdge::get(self : MlmetriccalibrationEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationEdge::set(self : MlmetriccalibrationEdge, i : Int, v : Double) -> MlmetriccalibrationEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationEdge::sum(self : MlmetriccalibrationEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationEdge::mean(self : MlmetriccalibrationEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationEdge::scale(self : MlmetriccalibrationEdge, f : Double) -> MlmetriccalibrationEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationEdge::add(self : MlmetriccalibrationEdge, other : MlmetriccalibrationEdge) -> MlmetriccalibrationEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationEdge::copy(self : MlmetriccalibrationEdge) -> MlmetriccalibrationEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationEdge::fill(self : MlmetriccalibrationEdge, v : Double) -> MlmetriccalibrationEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationEdge::min(self : MlmetriccalibrationEdge) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationEdge::max(self : MlmetriccalibrationEdge) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationEdge::to_string(self : MlmetriccalibrationEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_path_make(size : Int) -> MlmetriccalibrationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationPath::len(self : MlmetriccalibrationPath) -> Int { self.size }

pub fn MlmetriccalibrationPath::get(self : MlmetriccalibrationPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationPath::set(self : MlmetriccalibrationPath, i : Int, v : Double) -> MlmetriccalibrationPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationPath::sum(self : MlmetriccalibrationPath) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationPath::mean(self : MlmetriccalibrationPath) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationPath::scale(self : MlmetriccalibrationPath, f : Double) -> MlmetriccalibrationPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationPath::add(self : MlmetriccalibrationPath, other : MlmetriccalibrationPath) -> MlmetriccalibrationPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationPath::copy(self : MlmetriccalibrationPath) -> MlmetriccalibrationPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationPath::fill(self : MlmetriccalibrationPath, v : Double) -> MlmetriccalibrationPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationPath::min(self : MlmetriccalibrationPath) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationPath::max(self : MlmetriccalibrationPath) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationPath::to_string(self : MlmetriccalibrationPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_cluster_make(size : Int) -> MlmetriccalibrationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationCluster::len(self : MlmetriccalibrationCluster) -> Int { self.size }

pub fn MlmetriccalibrationCluster::get(self : MlmetriccalibrationCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationCluster::set(self : MlmetriccalibrationCluster, i : Int, v : Double) -> MlmetriccalibrationCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationCluster::sum(self : MlmetriccalibrationCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationCluster::mean(self : MlmetriccalibrationCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationCluster::scale(self : MlmetriccalibrationCluster, f : Double) -> MlmetriccalibrationCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationCluster::add(self : MlmetriccalibrationCluster, other : MlmetriccalibrationCluster) -> MlmetriccalibrationCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationCluster::copy(self : MlmetriccalibrationCluster) -> MlmetriccalibrationCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationCluster::fill(self : MlmetriccalibrationCluster, v : Double) -> MlmetriccalibrationCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationCluster::min(self : MlmetriccalibrationCluster) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationCluster::max(self : MlmetriccalibrationCluster) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationCluster::to_string(self : MlmetriccalibrationCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_model_make(size : Int) -> MlmetriccalibrationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationModel::len(self : MlmetriccalibrationModel) -> Int { self.size }

pub fn MlmetriccalibrationModel::get(self : MlmetriccalibrationModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationModel::set(self : MlmetriccalibrationModel, i : Int, v : Double) -> MlmetriccalibrationModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationModel::sum(self : MlmetriccalibrationModel) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationModel::mean(self : MlmetriccalibrationModel) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationModel::scale(self : MlmetriccalibrationModel, f : Double) -> MlmetriccalibrationModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationModel::add(self : MlmetriccalibrationModel, other : MlmetriccalibrationModel) -> MlmetriccalibrationModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationModel::copy(self : MlmetriccalibrationModel) -> MlmetriccalibrationModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationModel::fill(self : MlmetriccalibrationModel, v : Double) -> MlmetriccalibrationModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationModel::min(self : MlmetriccalibrationModel) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationModel::max(self : MlmetriccalibrationModel) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationModel::to_string(self : MlmetriccalibrationModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_layer_make(size : Int) -> MlmetriccalibrationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationLayer::len(self : MlmetriccalibrationLayer) -> Int { self.size }

pub fn MlmetriccalibrationLayer::get(self : MlmetriccalibrationLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationLayer::set(self : MlmetriccalibrationLayer, i : Int, v : Double) -> MlmetriccalibrationLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationLayer::sum(self : MlmetriccalibrationLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationLayer::mean(self : MlmetriccalibrationLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationLayer::scale(self : MlmetriccalibrationLayer, f : Double) -> MlmetriccalibrationLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationLayer::add(self : MlmetriccalibrationLayer, other : MlmetriccalibrationLayer) -> MlmetriccalibrationLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationLayer::copy(self : MlmetriccalibrationLayer) -> MlmetriccalibrationLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationLayer::fill(self : MlmetriccalibrationLayer, v : Double) -> MlmetriccalibrationLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationLayer::min(self : MlmetriccalibrationLayer) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationLayer::max(self : MlmetriccalibrationLayer) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationLayer::to_string(self : MlmetriccalibrationLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_buffer_make(size : Int) -> MlmetriccalibrationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationBuffer::len(self : MlmetriccalibrationBuffer) -> Int { self.size }

pub fn MlmetriccalibrationBuffer::get(self : MlmetriccalibrationBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationBuffer::set(self : MlmetriccalibrationBuffer, i : Int, v : Double) -> MlmetriccalibrationBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationBuffer::sum(self : MlmetriccalibrationBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationBuffer::mean(self : MlmetriccalibrationBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationBuffer::scale(self : MlmetriccalibrationBuffer, f : Double) -> MlmetriccalibrationBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationBuffer::add(self : MlmetriccalibrationBuffer, other : MlmetriccalibrationBuffer) -> MlmetriccalibrationBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationBuffer::copy(self : MlmetriccalibrationBuffer) -> MlmetriccalibrationBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationBuffer::fill(self : MlmetriccalibrationBuffer, v : Double) -> MlmetriccalibrationBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationBuffer::min(self : MlmetriccalibrationBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationBuffer::max(self : MlmetriccalibrationBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationBuffer::to_string(self : MlmetriccalibrationBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_cursor_make(size : Int) -> MlmetriccalibrationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationCursor::len(self : MlmetriccalibrationCursor) -> Int { self.size }

pub fn MlmetriccalibrationCursor::get(self : MlmetriccalibrationCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationCursor::set(self : MlmetriccalibrationCursor, i : Int, v : Double) -> MlmetriccalibrationCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationCursor::sum(self : MlmetriccalibrationCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationCursor::mean(self : MlmetriccalibrationCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationCursor::scale(self : MlmetriccalibrationCursor, f : Double) -> MlmetriccalibrationCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationCursor::add(self : MlmetriccalibrationCursor, other : MlmetriccalibrationCursor) -> MlmetriccalibrationCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationCursor::copy(self : MlmetriccalibrationCursor) -> MlmetriccalibrationCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationCursor::fill(self : MlmetriccalibrationCursor, v : Double) -> MlmetriccalibrationCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationCursor::min(self : MlmetriccalibrationCursor) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationCursor::max(self : MlmetriccalibrationCursor) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationCursor::to_string(self : MlmetriccalibrationCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_view_make(size : Int) -> MlmetriccalibrationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationView::len(self : MlmetriccalibrationView) -> Int { self.size }

pub fn MlmetriccalibrationView::get(self : MlmetriccalibrationView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationView::set(self : MlmetriccalibrationView, i : Int, v : Double) -> MlmetriccalibrationView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationView::sum(self : MlmetriccalibrationView) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationView::mean(self : MlmetriccalibrationView) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationView::scale(self : MlmetriccalibrationView, f : Double) -> MlmetriccalibrationView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationView::add(self : MlmetriccalibrationView, other : MlmetriccalibrationView) -> MlmetriccalibrationView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationView::copy(self : MlmetriccalibrationView) -> MlmetriccalibrationView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationView::fill(self : MlmetriccalibrationView, v : Double) -> MlmetriccalibrationView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationView::min(self : MlmetriccalibrationView) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationView::max(self : MlmetriccalibrationView) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationView::to_string(self : MlmetriccalibrationView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_range_make(size : Int) -> MlmetriccalibrationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationRange::len(self : MlmetriccalibrationRange) -> Int { self.size }

pub fn MlmetriccalibrationRange::get(self : MlmetriccalibrationRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationRange::set(self : MlmetriccalibrationRange, i : Int, v : Double) -> MlmetriccalibrationRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationRange::sum(self : MlmetriccalibrationRange) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationRange::mean(self : MlmetriccalibrationRange) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationRange::scale(self : MlmetriccalibrationRange, f : Double) -> MlmetriccalibrationRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationRange::add(self : MlmetriccalibrationRange, other : MlmetriccalibrationRange) -> MlmetriccalibrationRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationRange::copy(self : MlmetriccalibrationRange) -> MlmetriccalibrationRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationRange::fill(self : MlmetriccalibrationRange, v : Double) -> MlmetriccalibrationRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationRange::min(self : MlmetriccalibrationRange) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationRange::max(self : MlmetriccalibrationRange) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationRange::to_string(self : MlmetriccalibrationRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_slice_make(size : Int) -> MlmetriccalibrationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetriccalibrationSlice::len(self : MlmetriccalibrationSlice) -> Int { self.size }

pub fn MlmetriccalibrationSlice::get(self : MlmetriccalibrationSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetriccalibrationSlice::set(self : MlmetriccalibrationSlice, i : Int, v : Double) -> MlmetriccalibrationSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationSlice::sum(self : MlmetriccalibrationSlice) -> Double { @_common.sum(self.data) }

pub fn MlmetriccalibrationSlice::mean(self : MlmetriccalibrationSlice) -> Double { @_common.mean(self.data) }

pub fn MlmetriccalibrationSlice::scale(self : MlmetriccalibrationSlice, f : Double) -> MlmetriccalibrationSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationSlice::add(self : MlmetriccalibrationSlice, other : MlmetriccalibrationSlice) -> MlmetriccalibrationSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetriccalibrationSlice::copy(self : MlmetriccalibrationSlice) -> MlmetriccalibrationSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationSlice::fill(self : MlmetriccalibrationSlice, v : Double) -> MlmetriccalibrationSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetriccalibrationSlice::min(self : MlmetriccalibrationSlice) -> Double { @_common.min(self.data) }

pub fn MlmetriccalibrationSlice::max(self : MlmetriccalibrationSlice) -> Double { @_common.max(self.data) }

pub fn MlmetriccalibrationSlice::to_string(self : MlmetriccalibrationSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

