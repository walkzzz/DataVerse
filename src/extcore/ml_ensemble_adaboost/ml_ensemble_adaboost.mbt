///===
/// extcore/ml_ensemble_adaboost

pub(all) struct MlensembleadaboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_adaboost_make_point(x : Double, y : Double) -> MlensembleadaboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_adaboost_make_point3(x : Double, y : Double, z : Double) -> MlensembleadaboostPoint {
  { x, y, z, label: 0 }
}

pub fn MlensembleadaboostPoint::x(self : MlensembleadaboostPoint) -> Double { self.x }

pub fn MlensembleadaboostPoint::y(self : MlensembleadaboostPoint) -> Double { self.y }

pub fn MlensembleadaboostPoint::z(self : MlensembleadaboostPoint) -> Double { self.z }

pub fn MlensembleadaboostPoint::label(self : MlensembleadaboostPoint) -> Int { self.label }

pub fn MlensembleadaboostPoint::dist(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensembleadaboostPoint::add(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensembleadaboostPoint::sub(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensembleadaboostPoint::scale(self : MlensembleadaboostPoint, s : Double) -> MlensembleadaboostPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensembleadaboostPoint::dot(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensembleadaboostPoint::cross(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensembleadaboostPoint::norm(self : MlensembleadaboostPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensembleadaboostPoint::normalize(self : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensembleadaboostPoint::negate(self : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensembleadaboostPoint::mid(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensembleadaboostPoint::lerp(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint, t : Double) -> MlensembleadaboostPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensembleadaboostPoint::to_string(self : MlensembleadaboostPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensembleadaboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_adaboost_make_series(vals : Array[Double], name : String) -> MlensembleadaboostSeries {
  { vals, name, meta: 0 }
}

pub fn MlensembleadaboostSeries::len(self : MlensembleadaboostSeries) -> Int { self.vals.length() }

pub fn MlensembleadaboostSeries::sum(self : MlensembleadaboostSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensembleadaboostSeries::mean(self : MlensembleadaboostSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensembleadaboostSeries::min(self : MlensembleadaboostSeries) -> Double { @_common.min(self.vals) }

pub fn MlensembleadaboostSeries::max(self : MlensembleadaboostSeries) -> Double { @_common.max(self.vals) }

pub fn MlensembleadaboostSeries::range(self : MlensembleadaboostSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensembleadaboostSeries::variance(self : MlensembleadaboostSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensembleadaboostSeries::std(self : MlensembleadaboostSeries) -> Double { @_common.std(self.vals) }

pub fn MlensembleadaboostSeries::median(self : MlensembleadaboostSeries) -> Double { @_common.median(self.vals) }

pub fn MlensembleadaboostSeries::scale(self : MlensembleadaboostSeries, f : Double) -> MlensembleadaboostSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensembleadaboostSeries::add(self : MlensembleadaboostSeries, other : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensembleadaboostSeries::sub(self : MlensembleadaboostSeries, other : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensembleadaboostSeries::normalize(self : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensembleadaboostSeries::cumsum(self : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensembleadaboostSeries::to_string(self : MlensembleadaboostSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensembleadaboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_adaboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensembleadaboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_adaboost_matrix_identity(n : Int) -> MlensembleadaboostMatrix {
  let m = ml_ensemble_adaboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensembleadaboostMatrix::get(self : MlensembleadaboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensembleadaboostMatrix::transpose(self : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  let result = ml_ensemble_adaboost_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensembleadaboostMatrix::add(self : MlensembleadaboostMatrix, other : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_adaboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensembleadaboostMatrix::scale(self : MlensembleadaboostMatrix, s : Double) -> MlensembleadaboostMatrix {
  let result = ml_ensemble_adaboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensembleadaboostMatrix::multiply(self : MlensembleadaboostMatrix, other : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  if self.cols != other.rows { return ml_ensemble_adaboost_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_adaboost_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensembleadaboostMatrix::trace(self : MlensembleadaboostMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensembleadaboostMatrix::det(self : MlensembleadaboostMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensembleadaboostMatrix::norm(self : MlensembleadaboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensembleadaboostMatrix::to_string(self : MlensembleadaboostMatrix) -> String {
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

pub(all) struct MlensembleadaboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_adaboost_make_vector(comps : Array[Double]) -> MlensembleadaboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_adaboost_vector_zero(dim : Int) -> MlensembleadaboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensembleadaboostVector::add(self : MlensembleadaboostVector, other : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensembleadaboostVector::sub(self : MlensembleadaboostVector, other : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensembleadaboostVector::scale(self : MlensembleadaboostVector, s : Double) -> MlensembleadaboostVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensembleadaboostVector::dot(self : MlensembleadaboostVector, other : MlensembleadaboostVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensembleadaboostVector::norm(self : MlensembleadaboostVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensembleadaboostVector::normalize(self : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensembleadaboostVector::dist(self : MlensembleadaboostVector, other : MlensembleadaboostVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensembleadaboostVector::to_string(self : MlensembleadaboostVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensembleadaboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_frame_make(size : Int) -> MlensembleadaboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostFrame::len(self : MlensembleadaboostFrame) -> Int { self.size }

pub fn MlensembleadaboostFrame::get(self : MlensembleadaboostFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostFrame::set(self : MlensembleadaboostFrame, i : Int, v : Double) -> MlensembleadaboostFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostFrame::sum(self : MlensembleadaboostFrame) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostFrame::mean(self : MlensembleadaboostFrame) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostFrame::scale(self : MlensembleadaboostFrame, f : Double) -> MlensembleadaboostFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostFrame::add(self : MlensembleadaboostFrame, other : MlensembleadaboostFrame) -> MlensembleadaboostFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostFrame::copy(self : MlensembleadaboostFrame) -> MlensembleadaboostFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostFrame::fill(self : MlensembleadaboostFrame, v : Double) -> MlensembleadaboostFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostFrame::min(self : MlensembleadaboostFrame) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostFrame::max(self : MlensembleadaboostFrame) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostFrame::to_string(self : MlensembleadaboostFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_table_make(size : Int) -> MlensembleadaboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostTable::len(self : MlensembleadaboostTable) -> Int { self.size }

pub fn MlensembleadaboostTable::get(self : MlensembleadaboostTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostTable::set(self : MlensembleadaboostTable, i : Int, v : Double) -> MlensembleadaboostTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostTable::sum(self : MlensembleadaboostTable) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostTable::mean(self : MlensembleadaboostTable) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostTable::scale(self : MlensembleadaboostTable, f : Double) -> MlensembleadaboostTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostTable::add(self : MlensembleadaboostTable, other : MlensembleadaboostTable) -> MlensembleadaboostTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostTable::copy(self : MlensembleadaboostTable) -> MlensembleadaboostTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostTable::fill(self : MlensembleadaboostTable, v : Double) -> MlensembleadaboostTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostTable::min(self : MlensembleadaboostTable) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostTable::max(self : MlensembleadaboostTable) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostTable::to_string(self : MlensembleadaboostTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_graphn_make(size : Int) -> MlensembleadaboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostGraphN::len(self : MlensembleadaboostGraphN) -> Int { self.size }

pub fn MlensembleadaboostGraphN::get(self : MlensembleadaboostGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostGraphN::set(self : MlensembleadaboostGraphN, i : Int, v : Double) -> MlensembleadaboostGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostGraphN::sum(self : MlensembleadaboostGraphN) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostGraphN::mean(self : MlensembleadaboostGraphN) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostGraphN::scale(self : MlensembleadaboostGraphN, f : Double) -> MlensembleadaboostGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostGraphN::add(self : MlensembleadaboostGraphN, other : MlensembleadaboostGraphN) -> MlensembleadaboostGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostGraphN::copy(self : MlensembleadaboostGraphN) -> MlensembleadaboostGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostGraphN::fill(self : MlensembleadaboostGraphN, v : Double) -> MlensembleadaboostGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostGraphN::min(self : MlensembleadaboostGraphN) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostGraphN::max(self : MlensembleadaboostGraphN) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostGraphN::to_string(self : MlensembleadaboostGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_node_make(size : Int) -> MlensembleadaboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostNode::len(self : MlensembleadaboostNode) -> Int { self.size }

pub fn MlensembleadaboostNode::get(self : MlensembleadaboostNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostNode::set(self : MlensembleadaboostNode, i : Int, v : Double) -> MlensembleadaboostNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostNode::sum(self : MlensembleadaboostNode) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostNode::mean(self : MlensembleadaboostNode) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostNode::scale(self : MlensembleadaboostNode, f : Double) -> MlensembleadaboostNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostNode::add(self : MlensembleadaboostNode, other : MlensembleadaboostNode) -> MlensembleadaboostNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostNode::copy(self : MlensembleadaboostNode) -> MlensembleadaboostNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostNode::fill(self : MlensembleadaboostNode, v : Double) -> MlensembleadaboostNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostNode::min(self : MlensembleadaboostNode) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostNode::max(self : MlensembleadaboostNode) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostNode::to_string(self : MlensembleadaboostNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_edge_make(size : Int) -> MlensembleadaboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostEdge::len(self : MlensembleadaboostEdge) -> Int { self.size }

pub fn MlensembleadaboostEdge::get(self : MlensembleadaboostEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostEdge::set(self : MlensembleadaboostEdge, i : Int, v : Double) -> MlensembleadaboostEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostEdge::sum(self : MlensembleadaboostEdge) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostEdge::mean(self : MlensembleadaboostEdge) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostEdge::scale(self : MlensembleadaboostEdge, f : Double) -> MlensembleadaboostEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostEdge::add(self : MlensembleadaboostEdge, other : MlensembleadaboostEdge) -> MlensembleadaboostEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostEdge::copy(self : MlensembleadaboostEdge) -> MlensembleadaboostEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostEdge::fill(self : MlensembleadaboostEdge, v : Double) -> MlensembleadaboostEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostEdge::min(self : MlensembleadaboostEdge) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostEdge::max(self : MlensembleadaboostEdge) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostEdge::to_string(self : MlensembleadaboostEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_path_make(size : Int) -> MlensembleadaboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostPath::len(self : MlensembleadaboostPath) -> Int { self.size }

pub fn MlensembleadaboostPath::get(self : MlensembleadaboostPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostPath::set(self : MlensembleadaboostPath, i : Int, v : Double) -> MlensembleadaboostPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostPath::sum(self : MlensembleadaboostPath) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostPath::mean(self : MlensembleadaboostPath) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostPath::scale(self : MlensembleadaboostPath, f : Double) -> MlensembleadaboostPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostPath::add(self : MlensembleadaboostPath, other : MlensembleadaboostPath) -> MlensembleadaboostPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostPath::copy(self : MlensembleadaboostPath) -> MlensembleadaboostPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostPath::fill(self : MlensembleadaboostPath, v : Double) -> MlensembleadaboostPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostPath::min(self : MlensembleadaboostPath) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostPath::max(self : MlensembleadaboostPath) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostPath::to_string(self : MlensembleadaboostPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_cluster_make(size : Int) -> MlensembleadaboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostCluster::len(self : MlensembleadaboostCluster) -> Int { self.size }

pub fn MlensembleadaboostCluster::get(self : MlensembleadaboostCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostCluster::set(self : MlensembleadaboostCluster, i : Int, v : Double) -> MlensembleadaboostCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostCluster::sum(self : MlensembleadaboostCluster) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostCluster::mean(self : MlensembleadaboostCluster) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostCluster::scale(self : MlensembleadaboostCluster, f : Double) -> MlensembleadaboostCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostCluster::add(self : MlensembleadaboostCluster, other : MlensembleadaboostCluster) -> MlensembleadaboostCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostCluster::copy(self : MlensembleadaboostCluster) -> MlensembleadaboostCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostCluster::fill(self : MlensembleadaboostCluster, v : Double) -> MlensembleadaboostCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostCluster::min(self : MlensembleadaboostCluster) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostCluster::max(self : MlensembleadaboostCluster) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostCluster::to_string(self : MlensembleadaboostCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_model_make(size : Int) -> MlensembleadaboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostModel::len(self : MlensembleadaboostModel) -> Int { self.size }

pub fn MlensembleadaboostModel::get(self : MlensembleadaboostModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostModel::set(self : MlensembleadaboostModel, i : Int, v : Double) -> MlensembleadaboostModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostModel::sum(self : MlensembleadaboostModel) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostModel::mean(self : MlensembleadaboostModel) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostModel::scale(self : MlensembleadaboostModel, f : Double) -> MlensembleadaboostModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostModel::add(self : MlensembleadaboostModel, other : MlensembleadaboostModel) -> MlensembleadaboostModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostModel::copy(self : MlensembleadaboostModel) -> MlensembleadaboostModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostModel::fill(self : MlensembleadaboostModel, v : Double) -> MlensembleadaboostModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostModel::min(self : MlensembleadaboostModel) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostModel::max(self : MlensembleadaboostModel) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostModel::to_string(self : MlensembleadaboostModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_layer_make(size : Int) -> MlensembleadaboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostLayer::len(self : MlensembleadaboostLayer) -> Int { self.size }

pub fn MlensembleadaboostLayer::get(self : MlensembleadaboostLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostLayer::set(self : MlensembleadaboostLayer, i : Int, v : Double) -> MlensembleadaboostLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostLayer::sum(self : MlensembleadaboostLayer) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostLayer::mean(self : MlensembleadaboostLayer) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostLayer::scale(self : MlensembleadaboostLayer, f : Double) -> MlensembleadaboostLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostLayer::add(self : MlensembleadaboostLayer, other : MlensembleadaboostLayer) -> MlensembleadaboostLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostLayer::copy(self : MlensembleadaboostLayer) -> MlensembleadaboostLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostLayer::fill(self : MlensembleadaboostLayer, v : Double) -> MlensembleadaboostLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostLayer::min(self : MlensembleadaboostLayer) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostLayer::max(self : MlensembleadaboostLayer) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostLayer::to_string(self : MlensembleadaboostLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_buffer_make(size : Int) -> MlensembleadaboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostBuffer::len(self : MlensembleadaboostBuffer) -> Int { self.size }

pub fn MlensembleadaboostBuffer::get(self : MlensembleadaboostBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostBuffer::set(self : MlensembleadaboostBuffer, i : Int, v : Double) -> MlensembleadaboostBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostBuffer::sum(self : MlensembleadaboostBuffer) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostBuffer::mean(self : MlensembleadaboostBuffer) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostBuffer::scale(self : MlensembleadaboostBuffer, f : Double) -> MlensembleadaboostBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostBuffer::add(self : MlensembleadaboostBuffer, other : MlensembleadaboostBuffer) -> MlensembleadaboostBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostBuffer::copy(self : MlensembleadaboostBuffer) -> MlensembleadaboostBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostBuffer::fill(self : MlensembleadaboostBuffer, v : Double) -> MlensembleadaboostBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostBuffer::min(self : MlensembleadaboostBuffer) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostBuffer::max(self : MlensembleadaboostBuffer) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostBuffer::to_string(self : MlensembleadaboostBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_cursor_make(size : Int) -> MlensembleadaboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostCursor::len(self : MlensembleadaboostCursor) -> Int { self.size }

pub fn MlensembleadaboostCursor::get(self : MlensembleadaboostCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostCursor::set(self : MlensembleadaboostCursor, i : Int, v : Double) -> MlensembleadaboostCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostCursor::sum(self : MlensembleadaboostCursor) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostCursor::mean(self : MlensembleadaboostCursor) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostCursor::scale(self : MlensembleadaboostCursor, f : Double) -> MlensembleadaboostCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostCursor::add(self : MlensembleadaboostCursor, other : MlensembleadaboostCursor) -> MlensembleadaboostCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostCursor::copy(self : MlensembleadaboostCursor) -> MlensembleadaboostCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostCursor::fill(self : MlensembleadaboostCursor, v : Double) -> MlensembleadaboostCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostCursor::min(self : MlensembleadaboostCursor) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostCursor::max(self : MlensembleadaboostCursor) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostCursor::to_string(self : MlensembleadaboostCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_view_make(size : Int) -> MlensembleadaboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostView::len(self : MlensembleadaboostView) -> Int { self.size }

pub fn MlensembleadaboostView::get(self : MlensembleadaboostView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostView::set(self : MlensembleadaboostView, i : Int, v : Double) -> MlensembleadaboostView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostView::sum(self : MlensembleadaboostView) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostView::mean(self : MlensembleadaboostView) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostView::scale(self : MlensembleadaboostView, f : Double) -> MlensembleadaboostView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostView::add(self : MlensembleadaboostView, other : MlensembleadaboostView) -> MlensembleadaboostView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostView::copy(self : MlensembleadaboostView) -> MlensembleadaboostView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostView::fill(self : MlensembleadaboostView, v : Double) -> MlensembleadaboostView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostView::min(self : MlensembleadaboostView) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostView::max(self : MlensembleadaboostView) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostView::to_string(self : MlensembleadaboostView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_range_make(size : Int) -> MlensembleadaboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostRange::len(self : MlensembleadaboostRange) -> Int { self.size }

pub fn MlensembleadaboostRange::get(self : MlensembleadaboostRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostRange::set(self : MlensembleadaboostRange, i : Int, v : Double) -> MlensembleadaboostRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostRange::sum(self : MlensembleadaboostRange) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostRange::mean(self : MlensembleadaboostRange) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostRange::scale(self : MlensembleadaboostRange, f : Double) -> MlensembleadaboostRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostRange::add(self : MlensembleadaboostRange, other : MlensembleadaboostRange) -> MlensembleadaboostRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostRange::copy(self : MlensembleadaboostRange) -> MlensembleadaboostRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostRange::fill(self : MlensembleadaboostRange, v : Double) -> MlensembleadaboostRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostRange::min(self : MlensembleadaboostRange) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostRange::max(self : MlensembleadaboostRange) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostRange::to_string(self : MlensembleadaboostRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_slice_make(size : Int) -> MlensembleadaboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleadaboostSlice::len(self : MlensembleadaboostSlice) -> Int { self.size }

pub fn MlensembleadaboostSlice::get(self : MlensembleadaboostSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleadaboostSlice::set(self : MlensembleadaboostSlice, i : Int, v : Double) -> MlensembleadaboostSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostSlice::sum(self : MlensembleadaboostSlice) -> Double { @_common.sum(self.data) }

pub fn MlensembleadaboostSlice::mean(self : MlensembleadaboostSlice) -> Double { @_common.mean(self.data) }

pub fn MlensembleadaboostSlice::scale(self : MlensembleadaboostSlice, f : Double) -> MlensembleadaboostSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostSlice::add(self : MlensembleadaboostSlice, other : MlensembleadaboostSlice) -> MlensembleadaboostSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleadaboostSlice::copy(self : MlensembleadaboostSlice) -> MlensembleadaboostSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostSlice::fill(self : MlensembleadaboostSlice, v : Double) -> MlensembleadaboostSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleadaboostSlice::min(self : MlensembleadaboostSlice) -> Double { @_common.min(self.data) }

pub fn MlensembleadaboostSlice::max(self : MlensembleadaboostSlice) -> Double { @_common.max(self.data) }

pub fn MlensembleadaboostSlice::to_string(self : MlensembleadaboostSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

