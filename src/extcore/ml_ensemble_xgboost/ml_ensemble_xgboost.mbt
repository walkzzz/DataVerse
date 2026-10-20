///===
/// extcore/ml_ensemble_xgboost

pub(all) struct MlensemblexgboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_xgboost_make_point(x : Double, y : Double) -> MlensemblexgboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_xgboost_make_point3(x : Double, y : Double, z : Double) -> MlensemblexgboostPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblexgboostPoint::x(self : MlensemblexgboostPoint) -> Double { self.x }

pub fn MlensemblexgboostPoint::y(self : MlensemblexgboostPoint) -> Double { self.y }

pub fn MlensemblexgboostPoint::z(self : MlensemblexgboostPoint) -> Double { self.z }

pub fn MlensemblexgboostPoint::label(self : MlensemblexgboostPoint) -> Int { self.label }

pub fn MlensemblexgboostPoint::dist(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblexgboostPoint::add(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblexgboostPoint::sub(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblexgboostPoint::scale(self : MlensemblexgboostPoint, s : Double) -> MlensemblexgboostPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblexgboostPoint::dot(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblexgboostPoint::cross(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblexgboostPoint::norm(self : MlensemblexgboostPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblexgboostPoint::normalize(self : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblexgboostPoint::negate(self : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblexgboostPoint::mid(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblexgboostPoint::lerp(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint, t : Double) -> MlensemblexgboostPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblexgboostPoint::to_string(self : MlensemblexgboostPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblexgboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_xgboost_make_series(vals : Array[Double], name : String) -> MlensemblexgboostSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblexgboostSeries::len(self : MlensemblexgboostSeries) -> Int { self.vals.length() }

pub fn MlensemblexgboostSeries::sum(self : MlensemblexgboostSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblexgboostSeries::mean(self : MlensemblexgboostSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblexgboostSeries::min(self : MlensemblexgboostSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblexgboostSeries::max(self : MlensemblexgboostSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblexgboostSeries::range(self : MlensemblexgboostSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblexgboostSeries::variance(self : MlensemblexgboostSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblexgboostSeries::std(self : MlensemblexgboostSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblexgboostSeries::median(self : MlensemblexgboostSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblexgboostSeries::scale(self : MlensemblexgboostSeries, f : Double) -> MlensemblexgboostSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblexgboostSeries::add(self : MlensemblexgboostSeries, other : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblexgboostSeries::sub(self : MlensemblexgboostSeries, other : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblexgboostSeries::normalize(self : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblexgboostSeries::cumsum(self : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblexgboostSeries::to_string(self : MlensemblexgboostSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblexgboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_xgboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblexgboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_xgboost_matrix_identity(n : Int) -> MlensemblexgboostMatrix {
  let m = ml_ensemble_xgboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblexgboostMatrix::get(self : MlensemblexgboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblexgboostMatrix::transpose(self : MlensemblexgboostMatrix) -> MlensemblexgboostMatrix {
  let result = ml_ensemble_xgboost_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblexgboostMatrix::add(self : MlensemblexgboostMatrix, other : MlensemblexgboostMatrix) -> MlensemblexgboostMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_xgboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblexgboostMatrix::scale(self : MlensemblexgboostMatrix, s : Double) -> MlensemblexgboostMatrix {
  let result = ml_ensemble_xgboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblexgboostMatrix::multiply(self : MlensemblexgboostMatrix, other : MlensemblexgboostMatrix) -> MlensemblexgboostMatrix {
  if self.cols != other.rows { return ml_ensemble_xgboost_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_xgboost_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblexgboostMatrix::trace(self : MlensemblexgboostMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblexgboostMatrix::det(self : MlensemblexgboostMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblexgboostMatrix::norm(self : MlensemblexgboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblexgboostMatrix::to_string(self : MlensemblexgboostMatrix) -> String {
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

pub(all) struct MlensemblexgboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_xgboost_make_vector(comps : Array[Double]) -> MlensemblexgboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_xgboost_vector_zero(dim : Int) -> MlensemblexgboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblexgboostVector::add(self : MlensemblexgboostVector, other : MlensemblexgboostVector) -> MlensemblexgboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblexgboostVector::sub(self : MlensemblexgboostVector, other : MlensemblexgboostVector) -> MlensemblexgboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblexgboostVector::scale(self : MlensemblexgboostVector, s : Double) -> MlensemblexgboostVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblexgboostVector::dot(self : MlensemblexgboostVector, other : MlensemblexgboostVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblexgboostVector::norm(self : MlensemblexgboostVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblexgboostVector::normalize(self : MlensemblexgboostVector) -> MlensemblexgboostVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblexgboostVector::dist(self : MlensemblexgboostVector, other : MlensemblexgboostVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblexgboostVector::to_string(self : MlensemblexgboostVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblexgboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_frame_make(size : Int) -> MlensemblexgboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostFrame::len(self : MlensemblexgboostFrame) -> Int { self.size }

pub fn MlensemblexgboostFrame::get(self : MlensemblexgboostFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostFrame::set(self : MlensemblexgboostFrame, i : Int, v : Double) -> MlensemblexgboostFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostFrame::sum(self : MlensemblexgboostFrame) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostFrame::mean(self : MlensemblexgboostFrame) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostFrame::scale(self : MlensemblexgboostFrame, f : Double) -> MlensemblexgboostFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostFrame::add(self : MlensemblexgboostFrame, other : MlensemblexgboostFrame) -> MlensemblexgboostFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostFrame::copy(self : MlensemblexgboostFrame) -> MlensemblexgboostFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostFrame::fill(self : MlensemblexgboostFrame, v : Double) -> MlensemblexgboostFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostFrame::min(self : MlensemblexgboostFrame) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostFrame::max(self : MlensemblexgboostFrame) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostFrame::to_string(self : MlensemblexgboostFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_table_make(size : Int) -> MlensemblexgboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostTable::len(self : MlensemblexgboostTable) -> Int { self.size }

pub fn MlensemblexgboostTable::get(self : MlensemblexgboostTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostTable::set(self : MlensemblexgboostTable, i : Int, v : Double) -> MlensemblexgboostTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostTable::sum(self : MlensemblexgboostTable) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostTable::mean(self : MlensemblexgboostTable) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostTable::scale(self : MlensemblexgboostTable, f : Double) -> MlensemblexgboostTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostTable::add(self : MlensemblexgboostTable, other : MlensemblexgboostTable) -> MlensemblexgboostTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostTable::copy(self : MlensemblexgboostTable) -> MlensemblexgboostTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostTable::fill(self : MlensemblexgboostTable, v : Double) -> MlensemblexgboostTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostTable::min(self : MlensemblexgboostTable) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostTable::max(self : MlensemblexgboostTable) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostTable::to_string(self : MlensemblexgboostTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_graphn_make(size : Int) -> MlensemblexgboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostGraphN::len(self : MlensemblexgboostGraphN) -> Int { self.size }

pub fn MlensemblexgboostGraphN::get(self : MlensemblexgboostGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostGraphN::set(self : MlensemblexgboostGraphN, i : Int, v : Double) -> MlensemblexgboostGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostGraphN::sum(self : MlensemblexgboostGraphN) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostGraphN::mean(self : MlensemblexgboostGraphN) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostGraphN::scale(self : MlensemblexgboostGraphN, f : Double) -> MlensemblexgboostGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostGraphN::add(self : MlensemblexgboostGraphN, other : MlensemblexgboostGraphN) -> MlensemblexgboostGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostGraphN::copy(self : MlensemblexgboostGraphN) -> MlensemblexgboostGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostGraphN::fill(self : MlensemblexgboostGraphN, v : Double) -> MlensemblexgboostGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostGraphN::min(self : MlensemblexgboostGraphN) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostGraphN::max(self : MlensemblexgboostGraphN) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostGraphN::to_string(self : MlensemblexgboostGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_node_make(size : Int) -> MlensemblexgboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostNode::len(self : MlensemblexgboostNode) -> Int { self.size }

pub fn MlensemblexgboostNode::get(self : MlensemblexgboostNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostNode::set(self : MlensemblexgboostNode, i : Int, v : Double) -> MlensemblexgboostNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostNode::sum(self : MlensemblexgboostNode) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostNode::mean(self : MlensemblexgboostNode) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostNode::scale(self : MlensemblexgboostNode, f : Double) -> MlensemblexgboostNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostNode::add(self : MlensemblexgboostNode, other : MlensemblexgboostNode) -> MlensemblexgboostNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostNode::copy(self : MlensemblexgboostNode) -> MlensemblexgboostNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostNode::fill(self : MlensemblexgboostNode, v : Double) -> MlensemblexgboostNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostNode::min(self : MlensemblexgboostNode) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostNode::max(self : MlensemblexgboostNode) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostNode::to_string(self : MlensemblexgboostNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_edge_make(size : Int) -> MlensemblexgboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostEdge::len(self : MlensemblexgboostEdge) -> Int { self.size }

pub fn MlensemblexgboostEdge::get(self : MlensemblexgboostEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostEdge::set(self : MlensemblexgboostEdge, i : Int, v : Double) -> MlensemblexgboostEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostEdge::sum(self : MlensemblexgboostEdge) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostEdge::mean(self : MlensemblexgboostEdge) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostEdge::scale(self : MlensemblexgboostEdge, f : Double) -> MlensemblexgboostEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostEdge::add(self : MlensemblexgboostEdge, other : MlensemblexgboostEdge) -> MlensemblexgboostEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostEdge::copy(self : MlensemblexgboostEdge) -> MlensemblexgboostEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostEdge::fill(self : MlensemblexgboostEdge, v : Double) -> MlensemblexgboostEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostEdge::min(self : MlensemblexgboostEdge) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostEdge::max(self : MlensemblexgboostEdge) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostEdge::to_string(self : MlensemblexgboostEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_path_make(size : Int) -> MlensemblexgboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostPath::len(self : MlensemblexgboostPath) -> Int { self.size }

pub fn MlensemblexgboostPath::get(self : MlensemblexgboostPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostPath::set(self : MlensemblexgboostPath, i : Int, v : Double) -> MlensemblexgboostPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostPath::sum(self : MlensemblexgboostPath) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostPath::mean(self : MlensemblexgboostPath) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostPath::scale(self : MlensemblexgboostPath, f : Double) -> MlensemblexgboostPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostPath::add(self : MlensemblexgboostPath, other : MlensemblexgboostPath) -> MlensemblexgboostPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostPath::copy(self : MlensemblexgboostPath) -> MlensemblexgboostPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostPath::fill(self : MlensemblexgboostPath, v : Double) -> MlensemblexgboostPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostPath::min(self : MlensemblexgboostPath) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostPath::max(self : MlensemblexgboostPath) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostPath::to_string(self : MlensemblexgboostPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_cluster_make(size : Int) -> MlensemblexgboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostCluster::len(self : MlensemblexgboostCluster) -> Int { self.size }

pub fn MlensemblexgboostCluster::get(self : MlensemblexgboostCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostCluster::set(self : MlensemblexgboostCluster, i : Int, v : Double) -> MlensemblexgboostCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostCluster::sum(self : MlensemblexgboostCluster) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostCluster::mean(self : MlensemblexgboostCluster) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostCluster::scale(self : MlensemblexgboostCluster, f : Double) -> MlensemblexgboostCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostCluster::add(self : MlensemblexgboostCluster, other : MlensemblexgboostCluster) -> MlensemblexgboostCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostCluster::copy(self : MlensemblexgboostCluster) -> MlensemblexgboostCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostCluster::fill(self : MlensemblexgboostCluster, v : Double) -> MlensemblexgboostCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostCluster::min(self : MlensemblexgboostCluster) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostCluster::max(self : MlensemblexgboostCluster) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostCluster::to_string(self : MlensemblexgboostCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_model_make(size : Int) -> MlensemblexgboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostModel::len(self : MlensemblexgboostModel) -> Int { self.size }

pub fn MlensemblexgboostModel::get(self : MlensemblexgboostModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostModel::set(self : MlensemblexgboostModel, i : Int, v : Double) -> MlensemblexgboostModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostModel::sum(self : MlensemblexgboostModel) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostModel::mean(self : MlensemblexgboostModel) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostModel::scale(self : MlensemblexgboostModel, f : Double) -> MlensemblexgboostModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostModel::add(self : MlensemblexgboostModel, other : MlensemblexgboostModel) -> MlensemblexgboostModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostModel::copy(self : MlensemblexgboostModel) -> MlensemblexgboostModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostModel::fill(self : MlensemblexgboostModel, v : Double) -> MlensemblexgboostModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostModel::min(self : MlensemblexgboostModel) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostModel::max(self : MlensemblexgboostModel) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostModel::to_string(self : MlensemblexgboostModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_layer_make(size : Int) -> MlensemblexgboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostLayer::len(self : MlensemblexgboostLayer) -> Int { self.size }

pub fn MlensemblexgboostLayer::get(self : MlensemblexgboostLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostLayer::set(self : MlensemblexgboostLayer, i : Int, v : Double) -> MlensemblexgboostLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostLayer::sum(self : MlensemblexgboostLayer) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostLayer::mean(self : MlensemblexgboostLayer) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostLayer::scale(self : MlensemblexgboostLayer, f : Double) -> MlensemblexgboostLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostLayer::add(self : MlensemblexgboostLayer, other : MlensemblexgboostLayer) -> MlensemblexgboostLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostLayer::copy(self : MlensemblexgboostLayer) -> MlensemblexgboostLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostLayer::fill(self : MlensemblexgboostLayer, v : Double) -> MlensemblexgboostLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostLayer::min(self : MlensemblexgboostLayer) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostLayer::max(self : MlensemblexgboostLayer) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostLayer::to_string(self : MlensemblexgboostLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_buffer_make(size : Int) -> MlensemblexgboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostBuffer::len(self : MlensemblexgboostBuffer) -> Int { self.size }

pub fn MlensemblexgboostBuffer::get(self : MlensemblexgboostBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostBuffer::set(self : MlensemblexgboostBuffer, i : Int, v : Double) -> MlensemblexgboostBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostBuffer::sum(self : MlensemblexgboostBuffer) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostBuffer::mean(self : MlensemblexgboostBuffer) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostBuffer::scale(self : MlensemblexgboostBuffer, f : Double) -> MlensemblexgboostBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostBuffer::add(self : MlensemblexgboostBuffer, other : MlensemblexgboostBuffer) -> MlensemblexgboostBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostBuffer::copy(self : MlensemblexgboostBuffer) -> MlensemblexgboostBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostBuffer::fill(self : MlensemblexgboostBuffer, v : Double) -> MlensemblexgboostBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostBuffer::min(self : MlensemblexgboostBuffer) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostBuffer::max(self : MlensemblexgboostBuffer) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostBuffer::to_string(self : MlensemblexgboostBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_cursor_make(size : Int) -> MlensemblexgboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostCursor::len(self : MlensemblexgboostCursor) -> Int { self.size }

pub fn MlensemblexgboostCursor::get(self : MlensemblexgboostCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostCursor::set(self : MlensemblexgboostCursor, i : Int, v : Double) -> MlensemblexgboostCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostCursor::sum(self : MlensemblexgboostCursor) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostCursor::mean(self : MlensemblexgboostCursor) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostCursor::scale(self : MlensemblexgboostCursor, f : Double) -> MlensemblexgboostCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostCursor::add(self : MlensemblexgboostCursor, other : MlensemblexgboostCursor) -> MlensemblexgboostCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostCursor::copy(self : MlensemblexgboostCursor) -> MlensemblexgboostCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostCursor::fill(self : MlensemblexgboostCursor, v : Double) -> MlensemblexgboostCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostCursor::min(self : MlensemblexgboostCursor) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostCursor::max(self : MlensemblexgboostCursor) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostCursor::to_string(self : MlensemblexgboostCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_view_make(size : Int) -> MlensemblexgboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostView::len(self : MlensemblexgboostView) -> Int { self.size }

pub fn MlensemblexgboostView::get(self : MlensemblexgboostView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostView::set(self : MlensemblexgboostView, i : Int, v : Double) -> MlensemblexgboostView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostView::sum(self : MlensemblexgboostView) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostView::mean(self : MlensemblexgboostView) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostView::scale(self : MlensemblexgboostView, f : Double) -> MlensemblexgboostView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostView::add(self : MlensemblexgboostView, other : MlensemblexgboostView) -> MlensemblexgboostView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostView::copy(self : MlensemblexgboostView) -> MlensemblexgboostView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostView::fill(self : MlensemblexgboostView, v : Double) -> MlensemblexgboostView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostView::min(self : MlensemblexgboostView) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostView::max(self : MlensemblexgboostView) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostView::to_string(self : MlensemblexgboostView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_range_make(size : Int) -> MlensemblexgboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostRange::len(self : MlensemblexgboostRange) -> Int { self.size }

pub fn MlensemblexgboostRange::get(self : MlensemblexgboostRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostRange::set(self : MlensemblexgboostRange, i : Int, v : Double) -> MlensemblexgboostRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostRange::sum(self : MlensemblexgboostRange) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostRange::mean(self : MlensemblexgboostRange) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostRange::scale(self : MlensemblexgboostRange, f : Double) -> MlensemblexgboostRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostRange::add(self : MlensemblexgboostRange, other : MlensemblexgboostRange) -> MlensemblexgboostRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostRange::copy(self : MlensemblexgboostRange) -> MlensemblexgboostRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostRange::fill(self : MlensemblexgboostRange, v : Double) -> MlensemblexgboostRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostRange::min(self : MlensemblexgboostRange) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostRange::max(self : MlensemblexgboostRange) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostRange::to_string(self : MlensemblexgboostRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_slice_make(size : Int) -> MlensemblexgboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblexgboostSlice::len(self : MlensemblexgboostSlice) -> Int { self.size }

pub fn MlensemblexgboostSlice::get(self : MlensemblexgboostSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblexgboostSlice::set(self : MlensemblexgboostSlice, i : Int, v : Double) -> MlensemblexgboostSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostSlice::sum(self : MlensemblexgboostSlice) -> Double { @_common.sum(self.data) }

pub fn MlensemblexgboostSlice::mean(self : MlensemblexgboostSlice) -> Double { @_common.mean(self.data) }

pub fn MlensemblexgboostSlice::scale(self : MlensemblexgboostSlice, f : Double) -> MlensemblexgboostSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostSlice::add(self : MlensemblexgboostSlice, other : MlensemblexgboostSlice) -> MlensemblexgboostSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblexgboostSlice::copy(self : MlensemblexgboostSlice) -> MlensemblexgboostSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostSlice::fill(self : MlensemblexgboostSlice, v : Double) -> MlensemblexgboostSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblexgboostSlice::min(self : MlensemblexgboostSlice) -> Double { @_common.min(self.data) }

pub fn MlensemblexgboostSlice::max(self : MlensemblexgboostSlice) -> Double { @_common.max(self.data) }

pub fn MlensemblexgboostSlice::to_string(self : MlensemblexgboostSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

