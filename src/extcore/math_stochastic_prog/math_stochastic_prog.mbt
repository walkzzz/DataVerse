///===
/// extcore/math_stochastic_prog

pub(all) struct MathstochasticprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_stochastic_prog_make_point(x : Double, y : Double) -> MathstochasticprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_stochastic_prog_make_point3(x : Double, y : Double, z : Double) -> MathstochasticprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathstochasticprogPoint::x(self : MathstochasticprogPoint) -> Double { self.x }

pub fn MathstochasticprogPoint::y(self : MathstochasticprogPoint) -> Double { self.y }

pub fn MathstochasticprogPoint::z(self : MathstochasticprogPoint) -> Double { self.z }

pub fn MathstochasticprogPoint::label(self : MathstochasticprogPoint) -> Int { self.label }

pub fn MathstochasticprogPoint::dist(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathstochasticprogPoint::add(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathstochasticprogPoint::sub(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathstochasticprogPoint::scale(self : MathstochasticprogPoint, s : Double) -> MathstochasticprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathstochasticprogPoint::dot(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathstochasticprogPoint::cross(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathstochasticprogPoint::norm(self : MathstochasticprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathstochasticprogPoint::normalize(self : MathstochasticprogPoint) -> MathstochasticprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathstochasticprogPoint::negate(self : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathstochasticprogPoint::mid(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathstochasticprogPoint::lerp(self : MathstochasticprogPoint, other : MathstochasticprogPoint, t : Double) -> MathstochasticprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathstochasticprogPoint::to_string(self : MathstochasticprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathstochasticprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_stochastic_prog_make_series(vals : Array[Double], name : String) -> MathstochasticprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathstochasticprogSeries::len(self : MathstochasticprogSeries) -> Int { self.vals.length() }

pub fn MathstochasticprogSeries::sum(self : MathstochasticprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathstochasticprogSeries::mean(self : MathstochasticprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathstochasticprogSeries::min(self : MathstochasticprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathstochasticprogSeries::max(self : MathstochasticprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathstochasticprogSeries::range(self : MathstochasticprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathstochasticprogSeries::variance(self : MathstochasticprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathstochasticprogSeries::std(self : MathstochasticprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathstochasticprogSeries::median(self : MathstochasticprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathstochasticprogSeries::scale(self : MathstochasticprogSeries, f : Double) -> MathstochasticprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathstochasticprogSeries::add(self : MathstochasticprogSeries, other : MathstochasticprogSeries) -> MathstochasticprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathstochasticprogSeries::sub(self : MathstochasticprogSeries, other : MathstochasticprogSeries) -> MathstochasticprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathstochasticprogSeries::normalize(self : MathstochasticprogSeries) -> MathstochasticprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathstochasticprogSeries::cumsum(self : MathstochasticprogSeries) -> MathstochasticprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathstochasticprogSeries::to_string(self : MathstochasticprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathstochasticprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_stochastic_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathstochasticprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_stochastic_prog_matrix_identity(n : Int) -> MathstochasticprogMatrix {
  let m = math_stochastic_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathstochasticprogMatrix::get(self : MathstochasticprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathstochasticprogMatrix::transpose(self : MathstochasticprogMatrix) -> MathstochasticprogMatrix {
  let result = math_stochastic_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathstochasticprogMatrix::add(self : MathstochasticprogMatrix, other : MathstochasticprogMatrix) -> MathstochasticprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_stochastic_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathstochasticprogMatrix::scale(self : MathstochasticprogMatrix, s : Double) -> MathstochasticprogMatrix {
  let result = math_stochastic_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathstochasticprogMatrix::multiply(self : MathstochasticprogMatrix, other : MathstochasticprogMatrix) -> MathstochasticprogMatrix {
  if self.cols != other.rows { return math_stochastic_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_stochastic_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathstochasticprogMatrix::trace(self : MathstochasticprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathstochasticprogMatrix::det(self : MathstochasticprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathstochasticprogMatrix::norm(self : MathstochasticprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathstochasticprogMatrix::to_string(self : MathstochasticprogMatrix) -> String {
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

pub(all) struct MathstochasticprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_stochastic_prog_make_vector(comps : Array[Double]) -> MathstochasticprogVector {
  { comps, dim: comps.length() }
}

pub fn math_stochastic_prog_vector_zero(dim : Int) -> MathstochasticprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathstochasticprogVector::add(self : MathstochasticprogVector, other : MathstochasticprogVector) -> MathstochasticprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathstochasticprogVector::sub(self : MathstochasticprogVector, other : MathstochasticprogVector) -> MathstochasticprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathstochasticprogVector::scale(self : MathstochasticprogVector, s : Double) -> MathstochasticprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathstochasticprogVector::dot(self : MathstochasticprogVector, other : MathstochasticprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathstochasticprogVector::norm(self : MathstochasticprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathstochasticprogVector::normalize(self : MathstochasticprogVector) -> MathstochasticprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathstochasticprogVector::dist(self : MathstochasticprogVector, other : MathstochasticprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathstochasticprogVector::to_string(self : MathstochasticprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathstochasticprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_frame_make(size : Int) -> MathstochasticprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogFrame::len(self : MathstochasticprogFrame) -> Int { self.size }

pub fn MathstochasticprogFrame::get(self : MathstochasticprogFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogFrame::set(self : MathstochasticprogFrame, i : Int, v : Double) -> MathstochasticprogFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogFrame::sum(self : MathstochasticprogFrame) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogFrame::mean(self : MathstochasticprogFrame) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogFrame::scale(self : MathstochasticprogFrame, f : Double) -> MathstochasticprogFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogFrame::add(self : MathstochasticprogFrame, other : MathstochasticprogFrame) -> MathstochasticprogFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogFrame::copy(self : MathstochasticprogFrame) -> MathstochasticprogFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogFrame::fill(self : MathstochasticprogFrame, v : Double) -> MathstochasticprogFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogFrame::min(self : MathstochasticprogFrame) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogFrame::max(self : MathstochasticprogFrame) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogFrame::to_string(self : MathstochasticprogFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_table_make(size : Int) -> MathstochasticprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogTable::len(self : MathstochasticprogTable) -> Int { self.size }

pub fn MathstochasticprogTable::get(self : MathstochasticprogTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogTable::set(self : MathstochasticprogTable, i : Int, v : Double) -> MathstochasticprogTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogTable::sum(self : MathstochasticprogTable) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogTable::mean(self : MathstochasticprogTable) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogTable::scale(self : MathstochasticprogTable, f : Double) -> MathstochasticprogTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogTable::add(self : MathstochasticprogTable, other : MathstochasticprogTable) -> MathstochasticprogTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogTable::copy(self : MathstochasticprogTable) -> MathstochasticprogTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogTable::fill(self : MathstochasticprogTable, v : Double) -> MathstochasticprogTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogTable::min(self : MathstochasticprogTable) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogTable::max(self : MathstochasticprogTable) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogTable::to_string(self : MathstochasticprogTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_graphn_make(size : Int) -> MathstochasticprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogGraphN::len(self : MathstochasticprogGraphN) -> Int { self.size }

pub fn MathstochasticprogGraphN::get(self : MathstochasticprogGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogGraphN::set(self : MathstochasticprogGraphN, i : Int, v : Double) -> MathstochasticprogGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogGraphN::sum(self : MathstochasticprogGraphN) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogGraphN::mean(self : MathstochasticprogGraphN) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogGraphN::scale(self : MathstochasticprogGraphN, f : Double) -> MathstochasticprogGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogGraphN::add(self : MathstochasticprogGraphN, other : MathstochasticprogGraphN) -> MathstochasticprogGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogGraphN::copy(self : MathstochasticprogGraphN) -> MathstochasticprogGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogGraphN::fill(self : MathstochasticprogGraphN, v : Double) -> MathstochasticprogGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogGraphN::min(self : MathstochasticprogGraphN) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogGraphN::max(self : MathstochasticprogGraphN) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogGraphN::to_string(self : MathstochasticprogGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_node_make(size : Int) -> MathstochasticprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogNode::len(self : MathstochasticprogNode) -> Int { self.size }

pub fn MathstochasticprogNode::get(self : MathstochasticprogNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogNode::set(self : MathstochasticprogNode, i : Int, v : Double) -> MathstochasticprogNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogNode::sum(self : MathstochasticprogNode) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogNode::mean(self : MathstochasticprogNode) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogNode::scale(self : MathstochasticprogNode, f : Double) -> MathstochasticprogNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogNode::add(self : MathstochasticprogNode, other : MathstochasticprogNode) -> MathstochasticprogNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogNode::copy(self : MathstochasticprogNode) -> MathstochasticprogNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogNode::fill(self : MathstochasticprogNode, v : Double) -> MathstochasticprogNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogNode::min(self : MathstochasticprogNode) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogNode::max(self : MathstochasticprogNode) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogNode::to_string(self : MathstochasticprogNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_edge_make(size : Int) -> MathstochasticprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogEdge::len(self : MathstochasticprogEdge) -> Int { self.size }

pub fn MathstochasticprogEdge::get(self : MathstochasticprogEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogEdge::set(self : MathstochasticprogEdge, i : Int, v : Double) -> MathstochasticprogEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogEdge::sum(self : MathstochasticprogEdge) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogEdge::mean(self : MathstochasticprogEdge) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogEdge::scale(self : MathstochasticprogEdge, f : Double) -> MathstochasticprogEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogEdge::add(self : MathstochasticprogEdge, other : MathstochasticprogEdge) -> MathstochasticprogEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogEdge::copy(self : MathstochasticprogEdge) -> MathstochasticprogEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogEdge::fill(self : MathstochasticprogEdge, v : Double) -> MathstochasticprogEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogEdge::min(self : MathstochasticprogEdge) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogEdge::max(self : MathstochasticprogEdge) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogEdge::to_string(self : MathstochasticprogEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_path_make(size : Int) -> MathstochasticprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogPath::len(self : MathstochasticprogPath) -> Int { self.size }

pub fn MathstochasticprogPath::get(self : MathstochasticprogPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogPath::set(self : MathstochasticprogPath, i : Int, v : Double) -> MathstochasticprogPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogPath::sum(self : MathstochasticprogPath) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogPath::mean(self : MathstochasticprogPath) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogPath::scale(self : MathstochasticprogPath, f : Double) -> MathstochasticprogPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogPath::add(self : MathstochasticprogPath, other : MathstochasticprogPath) -> MathstochasticprogPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogPath::copy(self : MathstochasticprogPath) -> MathstochasticprogPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogPath::fill(self : MathstochasticprogPath, v : Double) -> MathstochasticprogPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogPath::min(self : MathstochasticprogPath) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogPath::max(self : MathstochasticprogPath) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogPath::to_string(self : MathstochasticprogPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_cluster_make(size : Int) -> MathstochasticprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogCluster::len(self : MathstochasticprogCluster) -> Int { self.size }

pub fn MathstochasticprogCluster::get(self : MathstochasticprogCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogCluster::set(self : MathstochasticprogCluster, i : Int, v : Double) -> MathstochasticprogCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogCluster::sum(self : MathstochasticprogCluster) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogCluster::mean(self : MathstochasticprogCluster) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogCluster::scale(self : MathstochasticprogCluster, f : Double) -> MathstochasticprogCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogCluster::add(self : MathstochasticprogCluster, other : MathstochasticprogCluster) -> MathstochasticprogCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogCluster::copy(self : MathstochasticprogCluster) -> MathstochasticprogCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogCluster::fill(self : MathstochasticprogCluster, v : Double) -> MathstochasticprogCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogCluster::min(self : MathstochasticprogCluster) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogCluster::max(self : MathstochasticprogCluster) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogCluster::to_string(self : MathstochasticprogCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_model_make(size : Int) -> MathstochasticprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogModel::len(self : MathstochasticprogModel) -> Int { self.size }

pub fn MathstochasticprogModel::get(self : MathstochasticprogModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogModel::set(self : MathstochasticprogModel, i : Int, v : Double) -> MathstochasticprogModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogModel::sum(self : MathstochasticprogModel) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogModel::mean(self : MathstochasticprogModel) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogModel::scale(self : MathstochasticprogModel, f : Double) -> MathstochasticprogModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogModel::add(self : MathstochasticprogModel, other : MathstochasticprogModel) -> MathstochasticprogModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogModel::copy(self : MathstochasticprogModel) -> MathstochasticprogModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogModel::fill(self : MathstochasticprogModel, v : Double) -> MathstochasticprogModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogModel::min(self : MathstochasticprogModel) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogModel::max(self : MathstochasticprogModel) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogModel::to_string(self : MathstochasticprogModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_layer_make(size : Int) -> MathstochasticprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogLayer::len(self : MathstochasticprogLayer) -> Int { self.size }

pub fn MathstochasticprogLayer::get(self : MathstochasticprogLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogLayer::set(self : MathstochasticprogLayer, i : Int, v : Double) -> MathstochasticprogLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogLayer::sum(self : MathstochasticprogLayer) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogLayer::mean(self : MathstochasticprogLayer) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogLayer::scale(self : MathstochasticprogLayer, f : Double) -> MathstochasticprogLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogLayer::add(self : MathstochasticprogLayer, other : MathstochasticprogLayer) -> MathstochasticprogLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogLayer::copy(self : MathstochasticprogLayer) -> MathstochasticprogLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogLayer::fill(self : MathstochasticprogLayer, v : Double) -> MathstochasticprogLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogLayer::min(self : MathstochasticprogLayer) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogLayer::max(self : MathstochasticprogLayer) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogLayer::to_string(self : MathstochasticprogLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_buffer_make(size : Int) -> MathstochasticprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogBuffer::len(self : MathstochasticprogBuffer) -> Int { self.size }

pub fn MathstochasticprogBuffer::get(self : MathstochasticprogBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogBuffer::set(self : MathstochasticprogBuffer, i : Int, v : Double) -> MathstochasticprogBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogBuffer::sum(self : MathstochasticprogBuffer) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogBuffer::mean(self : MathstochasticprogBuffer) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogBuffer::scale(self : MathstochasticprogBuffer, f : Double) -> MathstochasticprogBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogBuffer::add(self : MathstochasticprogBuffer, other : MathstochasticprogBuffer) -> MathstochasticprogBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogBuffer::copy(self : MathstochasticprogBuffer) -> MathstochasticprogBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogBuffer::fill(self : MathstochasticprogBuffer, v : Double) -> MathstochasticprogBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogBuffer::min(self : MathstochasticprogBuffer) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogBuffer::max(self : MathstochasticprogBuffer) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogBuffer::to_string(self : MathstochasticprogBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_cursor_make(size : Int) -> MathstochasticprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogCursor::len(self : MathstochasticprogCursor) -> Int { self.size }

pub fn MathstochasticprogCursor::get(self : MathstochasticprogCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogCursor::set(self : MathstochasticprogCursor, i : Int, v : Double) -> MathstochasticprogCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogCursor::sum(self : MathstochasticprogCursor) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogCursor::mean(self : MathstochasticprogCursor) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogCursor::scale(self : MathstochasticprogCursor, f : Double) -> MathstochasticprogCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogCursor::add(self : MathstochasticprogCursor, other : MathstochasticprogCursor) -> MathstochasticprogCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogCursor::copy(self : MathstochasticprogCursor) -> MathstochasticprogCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogCursor::fill(self : MathstochasticprogCursor, v : Double) -> MathstochasticprogCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogCursor::min(self : MathstochasticprogCursor) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogCursor::max(self : MathstochasticprogCursor) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogCursor::to_string(self : MathstochasticprogCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_view_make(size : Int) -> MathstochasticprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogView::len(self : MathstochasticprogView) -> Int { self.size }

pub fn MathstochasticprogView::get(self : MathstochasticprogView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogView::set(self : MathstochasticprogView, i : Int, v : Double) -> MathstochasticprogView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogView::sum(self : MathstochasticprogView) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogView::mean(self : MathstochasticprogView) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogView::scale(self : MathstochasticprogView, f : Double) -> MathstochasticprogView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogView::add(self : MathstochasticprogView, other : MathstochasticprogView) -> MathstochasticprogView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogView::copy(self : MathstochasticprogView) -> MathstochasticprogView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogView::fill(self : MathstochasticprogView, v : Double) -> MathstochasticprogView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogView::min(self : MathstochasticprogView) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogView::max(self : MathstochasticprogView) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogView::to_string(self : MathstochasticprogView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_range_make(size : Int) -> MathstochasticprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogRange::len(self : MathstochasticprogRange) -> Int { self.size }

pub fn MathstochasticprogRange::get(self : MathstochasticprogRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogRange::set(self : MathstochasticprogRange, i : Int, v : Double) -> MathstochasticprogRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogRange::sum(self : MathstochasticprogRange) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogRange::mean(self : MathstochasticprogRange) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogRange::scale(self : MathstochasticprogRange, f : Double) -> MathstochasticprogRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogRange::add(self : MathstochasticprogRange, other : MathstochasticprogRange) -> MathstochasticprogRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogRange::copy(self : MathstochasticprogRange) -> MathstochasticprogRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogRange::fill(self : MathstochasticprogRange, v : Double) -> MathstochasticprogRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogRange::min(self : MathstochasticprogRange) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogRange::max(self : MathstochasticprogRange) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogRange::to_string(self : MathstochasticprogRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_slice_make(size : Int) -> MathstochasticprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathstochasticprogSlice::len(self : MathstochasticprogSlice) -> Int { self.size }

pub fn MathstochasticprogSlice::get(self : MathstochasticprogSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathstochasticprogSlice::set(self : MathstochasticprogSlice, i : Int, v : Double) -> MathstochasticprogSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathstochasticprogSlice::sum(self : MathstochasticprogSlice) -> Double { @_common.sum(self.data) }

pub fn MathstochasticprogSlice::mean(self : MathstochasticprogSlice) -> Double { @_common.mean(self.data) }

pub fn MathstochasticprogSlice::scale(self : MathstochasticprogSlice, f : Double) -> MathstochasticprogSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogSlice::add(self : MathstochasticprogSlice, other : MathstochasticprogSlice) -> MathstochasticprogSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathstochasticprogSlice::copy(self : MathstochasticprogSlice) -> MathstochasticprogSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogSlice::fill(self : MathstochasticprogSlice, v : Double) -> MathstochasticprogSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathstochasticprogSlice::min(self : MathstochasticprogSlice) -> Double { @_common.min(self.data) }

pub fn MathstochasticprogSlice::max(self : MathstochasticprogSlice) -> Double { @_common.max(self.data) }

pub fn MathstochasticprogSlice::to_string(self : MathstochasticprogSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

