///===
/// extcore/ml_classify_naive_bayes

pub(all) struct MlclassifynaivebayesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_naive_bayes_make_point(x : Double, y : Double) -> MlclassifynaivebayesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_naive_bayes_make_point3(x : Double, y : Double, z : Double) -> MlclassifynaivebayesPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifynaivebayesPoint::x(self : MlclassifynaivebayesPoint) -> Double { self.x }

pub fn MlclassifynaivebayesPoint::y(self : MlclassifynaivebayesPoint) -> Double { self.y }

pub fn MlclassifynaivebayesPoint::z(self : MlclassifynaivebayesPoint) -> Double { self.z }

pub fn MlclassifynaivebayesPoint::label(self : MlclassifynaivebayesPoint) -> Int { self.label }

pub fn MlclassifynaivebayesPoint::dist(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifynaivebayesPoint::add(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifynaivebayesPoint::sub(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifynaivebayesPoint::scale(self : MlclassifynaivebayesPoint, s : Double) -> MlclassifynaivebayesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifynaivebayesPoint::dot(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifynaivebayesPoint::cross(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifynaivebayesPoint::norm(self : MlclassifynaivebayesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifynaivebayesPoint::normalize(self : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifynaivebayesPoint::negate(self : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifynaivebayesPoint::mid(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifynaivebayesPoint::lerp(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint, t : Double) -> MlclassifynaivebayesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifynaivebayesPoint::to_string(self : MlclassifynaivebayesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_naive_bayes_make_series(vals : Array[Double], name : String) -> MlclassifynaivebayesSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifynaivebayesSeries::len(self : MlclassifynaivebayesSeries) -> Int { self.vals.length() }

pub fn MlclassifynaivebayesSeries::sum(self : MlclassifynaivebayesSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifynaivebayesSeries::mean(self : MlclassifynaivebayesSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifynaivebayesSeries::min(self : MlclassifynaivebayesSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifynaivebayesSeries::max(self : MlclassifynaivebayesSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifynaivebayesSeries::range(self : MlclassifynaivebayesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifynaivebayesSeries::variance(self : MlclassifynaivebayesSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifynaivebayesSeries::std(self : MlclassifynaivebayesSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifynaivebayesSeries::median(self : MlclassifynaivebayesSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifynaivebayesSeries::scale(self : MlclassifynaivebayesSeries, f : Double) -> MlclassifynaivebayesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifynaivebayesSeries::add(self : MlclassifynaivebayesSeries, other : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifynaivebayesSeries::sub(self : MlclassifynaivebayesSeries, other : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifynaivebayesSeries::normalize(self : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifynaivebayesSeries::cumsum(self : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifynaivebayesSeries::to_string(self : MlclassifynaivebayesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifynaivebayesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_naive_bayes_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifynaivebayesMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_classify_naive_bayes_matrix_identity(n : Int) -> MlclassifynaivebayesMatrix {
  let m = ml_classify_naive_bayes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifynaivebayesMatrix::get(self : MlclassifynaivebayesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifynaivebayesMatrix::transpose(self : MlclassifynaivebayesMatrix) -> MlclassifynaivebayesMatrix {
  let result = ml_classify_naive_bayes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifynaivebayesMatrix::add(self : MlclassifynaivebayesMatrix, other : MlclassifynaivebayesMatrix) -> MlclassifynaivebayesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_naive_bayes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifynaivebayesMatrix::scale(self : MlclassifynaivebayesMatrix, s : Double) -> MlclassifynaivebayesMatrix {
  let result = ml_classify_naive_bayes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifynaivebayesMatrix::multiply(self : MlclassifynaivebayesMatrix, other : MlclassifynaivebayesMatrix) -> MlclassifynaivebayesMatrix {
  if self.cols != other.rows { return ml_classify_naive_bayes_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_naive_bayes_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlclassifynaivebayesMatrix::trace(self : MlclassifynaivebayesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifynaivebayesMatrix::det(self : MlclassifynaivebayesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifynaivebayesMatrix::norm(self : MlclassifynaivebayesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifynaivebayesMatrix::to_string(self : MlclassifynaivebayesMatrix) -> String {
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

pub(all) struct MlclassifynaivebayesVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_naive_bayes_make_vector(comps : Array[Double]) -> MlclassifynaivebayesVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_naive_bayes_vector_zero(dim : Int) -> MlclassifynaivebayesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifynaivebayesVector::add(self : MlclassifynaivebayesVector, other : MlclassifynaivebayesVector) -> MlclassifynaivebayesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifynaivebayesVector::sub(self : MlclassifynaivebayesVector, other : MlclassifynaivebayesVector) -> MlclassifynaivebayesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifynaivebayesVector::scale(self : MlclassifynaivebayesVector, s : Double) -> MlclassifynaivebayesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifynaivebayesVector::dot(self : MlclassifynaivebayesVector, other : MlclassifynaivebayesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifynaivebayesVector::norm(self : MlclassifynaivebayesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifynaivebayesVector::normalize(self : MlclassifynaivebayesVector) -> MlclassifynaivebayesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifynaivebayesVector::dist(self : MlclassifynaivebayesVector, other : MlclassifynaivebayesVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifynaivebayesVector::to_string(self : MlclassifynaivebayesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifynaivebayesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_frame_make(size : Int) -> MlclassifynaivebayesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesFrame::len(self : MlclassifynaivebayesFrame) -> Int { self.size }

pub fn MlclassifynaivebayesFrame::get(self : MlclassifynaivebayesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesFrame::set(self : MlclassifynaivebayesFrame, i : Int, v : Double) -> MlclassifynaivebayesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesFrame::sum(self : MlclassifynaivebayesFrame) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesFrame::mean(self : MlclassifynaivebayesFrame) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesFrame::scale(self : MlclassifynaivebayesFrame, f : Double) -> MlclassifynaivebayesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesFrame::add(self : MlclassifynaivebayesFrame, other : MlclassifynaivebayesFrame) -> MlclassifynaivebayesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesFrame::copy(self : MlclassifynaivebayesFrame) -> MlclassifynaivebayesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesFrame::fill(self : MlclassifynaivebayesFrame, v : Double) -> MlclassifynaivebayesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesFrame::min(self : MlclassifynaivebayesFrame) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesFrame::max(self : MlclassifynaivebayesFrame) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesFrame::to_string(self : MlclassifynaivebayesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_table_make(size : Int) -> MlclassifynaivebayesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesTable::len(self : MlclassifynaivebayesTable) -> Int { self.size }

pub fn MlclassifynaivebayesTable::get(self : MlclassifynaivebayesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesTable::set(self : MlclassifynaivebayesTable, i : Int, v : Double) -> MlclassifynaivebayesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesTable::sum(self : MlclassifynaivebayesTable) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesTable::mean(self : MlclassifynaivebayesTable) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesTable::scale(self : MlclassifynaivebayesTable, f : Double) -> MlclassifynaivebayesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesTable::add(self : MlclassifynaivebayesTable, other : MlclassifynaivebayesTable) -> MlclassifynaivebayesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesTable::copy(self : MlclassifynaivebayesTable) -> MlclassifynaivebayesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesTable::fill(self : MlclassifynaivebayesTable, v : Double) -> MlclassifynaivebayesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesTable::min(self : MlclassifynaivebayesTable) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesTable::max(self : MlclassifynaivebayesTable) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesTable::to_string(self : MlclassifynaivebayesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_graphn_make(size : Int) -> MlclassifynaivebayesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesGraphN::len(self : MlclassifynaivebayesGraphN) -> Int { self.size }

pub fn MlclassifynaivebayesGraphN::get(self : MlclassifynaivebayesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesGraphN::set(self : MlclassifynaivebayesGraphN, i : Int, v : Double) -> MlclassifynaivebayesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesGraphN::sum(self : MlclassifynaivebayesGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesGraphN::mean(self : MlclassifynaivebayesGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesGraphN::scale(self : MlclassifynaivebayesGraphN, f : Double) -> MlclassifynaivebayesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesGraphN::add(self : MlclassifynaivebayesGraphN, other : MlclassifynaivebayesGraphN) -> MlclassifynaivebayesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesGraphN::copy(self : MlclassifynaivebayesGraphN) -> MlclassifynaivebayesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesGraphN::fill(self : MlclassifynaivebayesGraphN, v : Double) -> MlclassifynaivebayesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesGraphN::min(self : MlclassifynaivebayesGraphN) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesGraphN::max(self : MlclassifynaivebayesGraphN) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesGraphN::to_string(self : MlclassifynaivebayesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_node_make(size : Int) -> MlclassifynaivebayesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesNode::len(self : MlclassifynaivebayesNode) -> Int { self.size }

pub fn MlclassifynaivebayesNode::get(self : MlclassifynaivebayesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesNode::set(self : MlclassifynaivebayesNode, i : Int, v : Double) -> MlclassifynaivebayesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesNode::sum(self : MlclassifynaivebayesNode) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesNode::mean(self : MlclassifynaivebayesNode) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesNode::scale(self : MlclassifynaivebayesNode, f : Double) -> MlclassifynaivebayesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesNode::add(self : MlclassifynaivebayesNode, other : MlclassifynaivebayesNode) -> MlclassifynaivebayesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesNode::copy(self : MlclassifynaivebayesNode) -> MlclassifynaivebayesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesNode::fill(self : MlclassifynaivebayesNode, v : Double) -> MlclassifynaivebayesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesNode::min(self : MlclassifynaivebayesNode) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesNode::max(self : MlclassifynaivebayesNode) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesNode::to_string(self : MlclassifynaivebayesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_edge_make(size : Int) -> MlclassifynaivebayesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesEdge::len(self : MlclassifynaivebayesEdge) -> Int { self.size }

pub fn MlclassifynaivebayesEdge::get(self : MlclassifynaivebayesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesEdge::set(self : MlclassifynaivebayesEdge, i : Int, v : Double) -> MlclassifynaivebayesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesEdge::sum(self : MlclassifynaivebayesEdge) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesEdge::mean(self : MlclassifynaivebayesEdge) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesEdge::scale(self : MlclassifynaivebayesEdge, f : Double) -> MlclassifynaivebayesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesEdge::add(self : MlclassifynaivebayesEdge, other : MlclassifynaivebayesEdge) -> MlclassifynaivebayesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesEdge::copy(self : MlclassifynaivebayesEdge) -> MlclassifynaivebayesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesEdge::fill(self : MlclassifynaivebayesEdge, v : Double) -> MlclassifynaivebayesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesEdge::min(self : MlclassifynaivebayesEdge) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesEdge::max(self : MlclassifynaivebayesEdge) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesEdge::to_string(self : MlclassifynaivebayesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_path_make(size : Int) -> MlclassifynaivebayesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesPath::len(self : MlclassifynaivebayesPath) -> Int { self.size }

pub fn MlclassifynaivebayesPath::get(self : MlclassifynaivebayesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesPath::set(self : MlclassifynaivebayesPath, i : Int, v : Double) -> MlclassifynaivebayesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesPath::sum(self : MlclassifynaivebayesPath) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesPath::mean(self : MlclassifynaivebayesPath) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesPath::scale(self : MlclassifynaivebayesPath, f : Double) -> MlclassifynaivebayesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesPath::add(self : MlclassifynaivebayesPath, other : MlclassifynaivebayesPath) -> MlclassifynaivebayesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesPath::copy(self : MlclassifynaivebayesPath) -> MlclassifynaivebayesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesPath::fill(self : MlclassifynaivebayesPath, v : Double) -> MlclassifynaivebayesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesPath::min(self : MlclassifynaivebayesPath) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesPath::max(self : MlclassifynaivebayesPath) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesPath::to_string(self : MlclassifynaivebayesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_cluster_make(size : Int) -> MlclassifynaivebayesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesCluster::len(self : MlclassifynaivebayesCluster) -> Int { self.size }

pub fn MlclassifynaivebayesCluster::get(self : MlclassifynaivebayesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesCluster::set(self : MlclassifynaivebayesCluster, i : Int, v : Double) -> MlclassifynaivebayesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesCluster::sum(self : MlclassifynaivebayesCluster) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesCluster::mean(self : MlclassifynaivebayesCluster) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesCluster::scale(self : MlclassifynaivebayesCluster, f : Double) -> MlclassifynaivebayesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesCluster::add(self : MlclassifynaivebayesCluster, other : MlclassifynaivebayesCluster) -> MlclassifynaivebayesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesCluster::copy(self : MlclassifynaivebayesCluster) -> MlclassifynaivebayesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesCluster::fill(self : MlclassifynaivebayesCluster, v : Double) -> MlclassifynaivebayesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesCluster::min(self : MlclassifynaivebayesCluster) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesCluster::max(self : MlclassifynaivebayesCluster) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesCluster::to_string(self : MlclassifynaivebayesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_model_make(size : Int) -> MlclassifynaivebayesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesModel::len(self : MlclassifynaivebayesModel) -> Int { self.size }

pub fn MlclassifynaivebayesModel::get(self : MlclassifynaivebayesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesModel::set(self : MlclassifynaivebayesModel, i : Int, v : Double) -> MlclassifynaivebayesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesModel::sum(self : MlclassifynaivebayesModel) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesModel::mean(self : MlclassifynaivebayesModel) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesModel::scale(self : MlclassifynaivebayesModel, f : Double) -> MlclassifynaivebayesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesModel::add(self : MlclassifynaivebayesModel, other : MlclassifynaivebayesModel) -> MlclassifynaivebayesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesModel::copy(self : MlclassifynaivebayesModel) -> MlclassifynaivebayesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesModel::fill(self : MlclassifynaivebayesModel, v : Double) -> MlclassifynaivebayesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesModel::min(self : MlclassifynaivebayesModel) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesModel::max(self : MlclassifynaivebayesModel) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesModel::to_string(self : MlclassifynaivebayesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_layer_make(size : Int) -> MlclassifynaivebayesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesLayer::len(self : MlclassifynaivebayesLayer) -> Int { self.size }

pub fn MlclassifynaivebayesLayer::get(self : MlclassifynaivebayesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesLayer::set(self : MlclassifynaivebayesLayer, i : Int, v : Double) -> MlclassifynaivebayesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesLayer::sum(self : MlclassifynaivebayesLayer) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesLayer::mean(self : MlclassifynaivebayesLayer) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesLayer::scale(self : MlclassifynaivebayesLayer, f : Double) -> MlclassifynaivebayesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesLayer::add(self : MlclassifynaivebayesLayer, other : MlclassifynaivebayesLayer) -> MlclassifynaivebayesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesLayer::copy(self : MlclassifynaivebayesLayer) -> MlclassifynaivebayesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesLayer::fill(self : MlclassifynaivebayesLayer, v : Double) -> MlclassifynaivebayesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesLayer::min(self : MlclassifynaivebayesLayer) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesLayer::max(self : MlclassifynaivebayesLayer) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesLayer::to_string(self : MlclassifynaivebayesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_buffer_make(size : Int) -> MlclassifynaivebayesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesBuffer::len(self : MlclassifynaivebayesBuffer) -> Int { self.size }

pub fn MlclassifynaivebayesBuffer::get(self : MlclassifynaivebayesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesBuffer::set(self : MlclassifynaivebayesBuffer, i : Int, v : Double) -> MlclassifynaivebayesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesBuffer::sum(self : MlclassifynaivebayesBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesBuffer::mean(self : MlclassifynaivebayesBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesBuffer::scale(self : MlclassifynaivebayesBuffer, f : Double) -> MlclassifynaivebayesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesBuffer::add(self : MlclassifynaivebayesBuffer, other : MlclassifynaivebayesBuffer) -> MlclassifynaivebayesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesBuffer::copy(self : MlclassifynaivebayesBuffer) -> MlclassifynaivebayesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesBuffer::fill(self : MlclassifynaivebayesBuffer, v : Double) -> MlclassifynaivebayesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesBuffer::min(self : MlclassifynaivebayesBuffer) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesBuffer::max(self : MlclassifynaivebayesBuffer) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesBuffer::to_string(self : MlclassifynaivebayesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_cursor_make(size : Int) -> MlclassifynaivebayesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesCursor::len(self : MlclassifynaivebayesCursor) -> Int { self.size }

pub fn MlclassifynaivebayesCursor::get(self : MlclassifynaivebayesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesCursor::set(self : MlclassifynaivebayesCursor, i : Int, v : Double) -> MlclassifynaivebayesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesCursor::sum(self : MlclassifynaivebayesCursor) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesCursor::mean(self : MlclassifynaivebayesCursor) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesCursor::scale(self : MlclassifynaivebayesCursor, f : Double) -> MlclassifynaivebayesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesCursor::add(self : MlclassifynaivebayesCursor, other : MlclassifynaivebayesCursor) -> MlclassifynaivebayesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesCursor::copy(self : MlclassifynaivebayesCursor) -> MlclassifynaivebayesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesCursor::fill(self : MlclassifynaivebayesCursor, v : Double) -> MlclassifynaivebayesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesCursor::min(self : MlclassifynaivebayesCursor) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesCursor::max(self : MlclassifynaivebayesCursor) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesCursor::to_string(self : MlclassifynaivebayesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_view_make(size : Int) -> MlclassifynaivebayesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesView::len(self : MlclassifynaivebayesView) -> Int { self.size }

pub fn MlclassifynaivebayesView::get(self : MlclassifynaivebayesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesView::set(self : MlclassifynaivebayesView, i : Int, v : Double) -> MlclassifynaivebayesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesView::sum(self : MlclassifynaivebayesView) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesView::mean(self : MlclassifynaivebayesView) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesView::scale(self : MlclassifynaivebayesView, f : Double) -> MlclassifynaivebayesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesView::add(self : MlclassifynaivebayesView, other : MlclassifynaivebayesView) -> MlclassifynaivebayesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesView::copy(self : MlclassifynaivebayesView) -> MlclassifynaivebayesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesView::fill(self : MlclassifynaivebayesView, v : Double) -> MlclassifynaivebayesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesView::min(self : MlclassifynaivebayesView) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesView::max(self : MlclassifynaivebayesView) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesView::to_string(self : MlclassifynaivebayesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_range_make(size : Int) -> MlclassifynaivebayesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesRange::len(self : MlclassifynaivebayesRange) -> Int { self.size }

pub fn MlclassifynaivebayesRange::get(self : MlclassifynaivebayesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesRange::set(self : MlclassifynaivebayesRange, i : Int, v : Double) -> MlclassifynaivebayesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesRange::sum(self : MlclassifynaivebayesRange) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesRange::mean(self : MlclassifynaivebayesRange) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesRange::scale(self : MlclassifynaivebayesRange, f : Double) -> MlclassifynaivebayesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesRange::add(self : MlclassifynaivebayesRange, other : MlclassifynaivebayesRange) -> MlclassifynaivebayesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesRange::copy(self : MlclassifynaivebayesRange) -> MlclassifynaivebayesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesRange::fill(self : MlclassifynaivebayesRange, v : Double) -> MlclassifynaivebayesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesRange::min(self : MlclassifynaivebayesRange) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesRange::max(self : MlclassifynaivebayesRange) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesRange::to_string(self : MlclassifynaivebayesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_slice_make(size : Int) -> MlclassifynaivebayesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifynaivebayesSlice::len(self : MlclassifynaivebayesSlice) -> Int { self.size }

pub fn MlclassifynaivebayesSlice::get(self : MlclassifynaivebayesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifynaivebayesSlice::set(self : MlclassifynaivebayesSlice, i : Int, v : Double) -> MlclassifynaivebayesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesSlice::sum(self : MlclassifynaivebayesSlice) -> Double { @_common.sum(self.data) }

pub fn MlclassifynaivebayesSlice::mean(self : MlclassifynaivebayesSlice) -> Double { @_common.mean(self.data) }

pub fn MlclassifynaivebayesSlice::scale(self : MlclassifynaivebayesSlice, f : Double) -> MlclassifynaivebayesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesSlice::add(self : MlclassifynaivebayesSlice, other : MlclassifynaivebayesSlice) -> MlclassifynaivebayesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifynaivebayesSlice::copy(self : MlclassifynaivebayesSlice) -> MlclassifynaivebayesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesSlice::fill(self : MlclassifynaivebayesSlice, v : Double) -> MlclassifynaivebayesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifynaivebayesSlice::min(self : MlclassifynaivebayesSlice) -> Double { @_common.min(self.data) }

pub fn MlclassifynaivebayesSlice::max(self : MlclassifynaivebayesSlice) -> Double { @_common.max(self.data) }

pub fn MlclassifynaivebayesSlice::to_string(self : MlclassifynaivebayesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

