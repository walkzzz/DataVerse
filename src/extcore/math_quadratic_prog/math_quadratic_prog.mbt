///===
/// extcore/math_quadratic_prog

pub(all) struct MathquadraticprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_quadratic_prog_make_point(x : Double, y : Double) -> MathquadraticprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_quadratic_prog_make_point3(x : Double, y : Double, z : Double) -> MathquadraticprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathquadraticprogPoint::x(self : MathquadraticprogPoint) -> Double { self.x }

pub fn MathquadraticprogPoint::y(self : MathquadraticprogPoint) -> Double { self.y }

pub fn MathquadraticprogPoint::z(self : MathquadraticprogPoint) -> Double { self.z }

pub fn MathquadraticprogPoint::label(self : MathquadraticprogPoint) -> Int { self.label }

pub fn MathquadraticprogPoint::dist(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathquadraticprogPoint::add(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathquadraticprogPoint::sub(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathquadraticprogPoint::scale(self : MathquadraticprogPoint, s : Double) -> MathquadraticprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathquadraticprogPoint::dot(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathquadraticprogPoint::cross(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathquadraticprogPoint::norm(self : MathquadraticprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathquadraticprogPoint::normalize(self : MathquadraticprogPoint) -> MathquadraticprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathquadraticprogPoint::negate(self : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathquadraticprogPoint::mid(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathquadraticprogPoint::lerp(self : MathquadraticprogPoint, other : MathquadraticprogPoint, t : Double) -> MathquadraticprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathquadraticprogPoint::to_string(self : MathquadraticprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathquadraticprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_quadratic_prog_make_series(vals : Array[Double], name : String) -> MathquadraticprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathquadraticprogSeries::len(self : MathquadraticprogSeries) -> Int { self.vals.length() }

pub fn MathquadraticprogSeries::sum(self : MathquadraticprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathquadraticprogSeries::mean(self : MathquadraticprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathquadraticprogSeries::min(self : MathquadraticprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathquadraticprogSeries::max(self : MathquadraticprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathquadraticprogSeries::range(self : MathquadraticprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathquadraticprogSeries::variance(self : MathquadraticprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathquadraticprogSeries::std(self : MathquadraticprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathquadraticprogSeries::median(self : MathquadraticprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathquadraticprogSeries::scale(self : MathquadraticprogSeries, f : Double) -> MathquadraticprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathquadraticprogSeries::add(self : MathquadraticprogSeries, other : MathquadraticprogSeries) -> MathquadraticprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathquadraticprogSeries::sub(self : MathquadraticprogSeries, other : MathquadraticprogSeries) -> MathquadraticprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathquadraticprogSeries::normalize(self : MathquadraticprogSeries) -> MathquadraticprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathquadraticprogSeries::cumsum(self : MathquadraticprogSeries) -> MathquadraticprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathquadraticprogSeries::to_string(self : MathquadraticprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathquadraticprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_quadratic_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathquadraticprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_quadratic_prog_matrix_identity(n : Int) -> MathquadraticprogMatrix {
  let m = math_quadratic_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathquadraticprogMatrix::get(self : MathquadraticprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathquadraticprogMatrix::transpose(self : MathquadraticprogMatrix) -> MathquadraticprogMatrix {
  let result = math_quadratic_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathquadraticprogMatrix::add(self : MathquadraticprogMatrix, other : MathquadraticprogMatrix) -> MathquadraticprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_quadratic_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathquadraticprogMatrix::scale(self : MathquadraticprogMatrix, s : Double) -> MathquadraticprogMatrix {
  let result = math_quadratic_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathquadraticprogMatrix::multiply(self : MathquadraticprogMatrix, other : MathquadraticprogMatrix) -> MathquadraticprogMatrix {
  if self.cols != other.rows { return math_quadratic_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_quadratic_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathquadraticprogMatrix::trace(self : MathquadraticprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathquadraticprogMatrix::det(self : MathquadraticprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathquadraticprogMatrix::norm(self : MathquadraticprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathquadraticprogMatrix::to_string(self : MathquadraticprogMatrix) -> String {
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

pub(all) struct MathquadraticprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_quadratic_prog_make_vector(comps : Array[Double]) -> MathquadraticprogVector {
  { comps, dim: comps.length() }
}

pub fn math_quadratic_prog_vector_zero(dim : Int) -> MathquadraticprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathquadraticprogVector::add(self : MathquadraticprogVector, other : MathquadraticprogVector) -> MathquadraticprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathquadraticprogVector::sub(self : MathquadraticprogVector, other : MathquadraticprogVector) -> MathquadraticprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathquadraticprogVector::scale(self : MathquadraticprogVector, s : Double) -> MathquadraticprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathquadraticprogVector::dot(self : MathquadraticprogVector, other : MathquadraticprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathquadraticprogVector::norm(self : MathquadraticprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathquadraticprogVector::normalize(self : MathquadraticprogVector) -> MathquadraticprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathquadraticprogVector::dist(self : MathquadraticprogVector, other : MathquadraticprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathquadraticprogVector::to_string(self : MathquadraticprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathquadraticprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_frame_make(size : Int) -> MathquadraticprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogFrame::len(self : MathquadraticprogFrame) -> Int { self.size }

pub fn MathquadraticprogFrame::get(self : MathquadraticprogFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogFrame::set(self : MathquadraticprogFrame, i : Int, v : Double) -> MathquadraticprogFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogFrame::sum(self : MathquadraticprogFrame) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogFrame::mean(self : MathquadraticprogFrame) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogFrame::scale(self : MathquadraticprogFrame, f : Double) -> MathquadraticprogFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogFrame::add(self : MathquadraticprogFrame, other : MathquadraticprogFrame) -> MathquadraticprogFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogFrame::copy(self : MathquadraticprogFrame) -> MathquadraticprogFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogFrame::fill(self : MathquadraticprogFrame, v : Double) -> MathquadraticprogFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogFrame::min(self : MathquadraticprogFrame) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogFrame::max(self : MathquadraticprogFrame) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogFrame::to_string(self : MathquadraticprogFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_table_make(size : Int) -> MathquadraticprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogTable::len(self : MathquadraticprogTable) -> Int { self.size }

pub fn MathquadraticprogTable::get(self : MathquadraticprogTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogTable::set(self : MathquadraticprogTable, i : Int, v : Double) -> MathquadraticprogTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogTable::sum(self : MathquadraticprogTable) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogTable::mean(self : MathquadraticprogTable) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogTable::scale(self : MathquadraticprogTable, f : Double) -> MathquadraticprogTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogTable::add(self : MathquadraticprogTable, other : MathquadraticprogTable) -> MathquadraticprogTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogTable::copy(self : MathquadraticprogTable) -> MathquadraticprogTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogTable::fill(self : MathquadraticprogTable, v : Double) -> MathquadraticprogTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogTable::min(self : MathquadraticprogTable) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogTable::max(self : MathquadraticprogTable) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogTable::to_string(self : MathquadraticprogTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_graphn_make(size : Int) -> MathquadraticprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogGraphN::len(self : MathquadraticprogGraphN) -> Int { self.size }

pub fn MathquadraticprogGraphN::get(self : MathquadraticprogGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogGraphN::set(self : MathquadraticprogGraphN, i : Int, v : Double) -> MathquadraticprogGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogGraphN::sum(self : MathquadraticprogGraphN) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogGraphN::mean(self : MathquadraticprogGraphN) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogGraphN::scale(self : MathquadraticprogGraphN, f : Double) -> MathquadraticprogGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogGraphN::add(self : MathquadraticprogGraphN, other : MathquadraticprogGraphN) -> MathquadraticprogGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogGraphN::copy(self : MathquadraticprogGraphN) -> MathquadraticprogGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogGraphN::fill(self : MathquadraticprogGraphN, v : Double) -> MathquadraticprogGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogGraphN::min(self : MathquadraticprogGraphN) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogGraphN::max(self : MathquadraticprogGraphN) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogGraphN::to_string(self : MathquadraticprogGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_node_make(size : Int) -> MathquadraticprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogNode::len(self : MathquadraticprogNode) -> Int { self.size }

pub fn MathquadraticprogNode::get(self : MathquadraticprogNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogNode::set(self : MathquadraticprogNode, i : Int, v : Double) -> MathquadraticprogNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogNode::sum(self : MathquadraticprogNode) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogNode::mean(self : MathquadraticprogNode) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogNode::scale(self : MathquadraticprogNode, f : Double) -> MathquadraticprogNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogNode::add(self : MathquadraticprogNode, other : MathquadraticprogNode) -> MathquadraticprogNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogNode::copy(self : MathquadraticprogNode) -> MathquadraticprogNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogNode::fill(self : MathquadraticprogNode, v : Double) -> MathquadraticprogNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogNode::min(self : MathquadraticprogNode) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogNode::max(self : MathquadraticprogNode) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogNode::to_string(self : MathquadraticprogNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_edge_make(size : Int) -> MathquadraticprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogEdge::len(self : MathquadraticprogEdge) -> Int { self.size }

pub fn MathquadraticprogEdge::get(self : MathquadraticprogEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogEdge::set(self : MathquadraticprogEdge, i : Int, v : Double) -> MathquadraticprogEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogEdge::sum(self : MathquadraticprogEdge) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogEdge::mean(self : MathquadraticprogEdge) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogEdge::scale(self : MathquadraticprogEdge, f : Double) -> MathquadraticprogEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogEdge::add(self : MathquadraticprogEdge, other : MathquadraticprogEdge) -> MathquadraticprogEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogEdge::copy(self : MathquadraticprogEdge) -> MathquadraticprogEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogEdge::fill(self : MathquadraticprogEdge, v : Double) -> MathquadraticprogEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogEdge::min(self : MathquadraticprogEdge) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogEdge::max(self : MathquadraticprogEdge) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogEdge::to_string(self : MathquadraticprogEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_path_make(size : Int) -> MathquadraticprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogPath::len(self : MathquadraticprogPath) -> Int { self.size }

pub fn MathquadraticprogPath::get(self : MathquadraticprogPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogPath::set(self : MathquadraticprogPath, i : Int, v : Double) -> MathquadraticprogPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogPath::sum(self : MathquadraticprogPath) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogPath::mean(self : MathquadraticprogPath) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogPath::scale(self : MathquadraticprogPath, f : Double) -> MathquadraticprogPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogPath::add(self : MathquadraticprogPath, other : MathquadraticprogPath) -> MathquadraticprogPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogPath::copy(self : MathquadraticprogPath) -> MathquadraticprogPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogPath::fill(self : MathquadraticprogPath, v : Double) -> MathquadraticprogPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogPath::min(self : MathquadraticprogPath) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogPath::max(self : MathquadraticprogPath) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogPath::to_string(self : MathquadraticprogPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_cluster_make(size : Int) -> MathquadraticprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogCluster::len(self : MathquadraticprogCluster) -> Int { self.size }

pub fn MathquadraticprogCluster::get(self : MathquadraticprogCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogCluster::set(self : MathquadraticprogCluster, i : Int, v : Double) -> MathquadraticprogCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogCluster::sum(self : MathquadraticprogCluster) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogCluster::mean(self : MathquadraticprogCluster) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogCluster::scale(self : MathquadraticprogCluster, f : Double) -> MathquadraticprogCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogCluster::add(self : MathquadraticprogCluster, other : MathquadraticprogCluster) -> MathquadraticprogCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogCluster::copy(self : MathquadraticprogCluster) -> MathquadraticprogCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogCluster::fill(self : MathquadraticprogCluster, v : Double) -> MathquadraticprogCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogCluster::min(self : MathquadraticprogCluster) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogCluster::max(self : MathquadraticprogCluster) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogCluster::to_string(self : MathquadraticprogCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_model_make(size : Int) -> MathquadraticprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogModel::len(self : MathquadraticprogModel) -> Int { self.size }

pub fn MathquadraticprogModel::get(self : MathquadraticprogModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogModel::set(self : MathquadraticprogModel, i : Int, v : Double) -> MathquadraticprogModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogModel::sum(self : MathquadraticprogModel) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogModel::mean(self : MathquadraticprogModel) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogModel::scale(self : MathquadraticprogModel, f : Double) -> MathquadraticprogModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogModel::add(self : MathquadraticprogModel, other : MathquadraticprogModel) -> MathquadraticprogModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogModel::copy(self : MathquadraticprogModel) -> MathquadraticprogModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogModel::fill(self : MathquadraticprogModel, v : Double) -> MathquadraticprogModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogModel::min(self : MathquadraticprogModel) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogModel::max(self : MathquadraticprogModel) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogModel::to_string(self : MathquadraticprogModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_layer_make(size : Int) -> MathquadraticprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogLayer::len(self : MathquadraticprogLayer) -> Int { self.size }

pub fn MathquadraticprogLayer::get(self : MathquadraticprogLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogLayer::set(self : MathquadraticprogLayer, i : Int, v : Double) -> MathquadraticprogLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogLayer::sum(self : MathquadraticprogLayer) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogLayer::mean(self : MathquadraticprogLayer) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogLayer::scale(self : MathquadraticprogLayer, f : Double) -> MathquadraticprogLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogLayer::add(self : MathquadraticprogLayer, other : MathquadraticprogLayer) -> MathquadraticprogLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogLayer::copy(self : MathquadraticprogLayer) -> MathquadraticprogLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogLayer::fill(self : MathquadraticprogLayer, v : Double) -> MathquadraticprogLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogLayer::min(self : MathquadraticprogLayer) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogLayer::max(self : MathquadraticprogLayer) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogLayer::to_string(self : MathquadraticprogLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_buffer_make(size : Int) -> MathquadraticprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogBuffer::len(self : MathquadraticprogBuffer) -> Int { self.size }

pub fn MathquadraticprogBuffer::get(self : MathquadraticprogBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogBuffer::set(self : MathquadraticprogBuffer, i : Int, v : Double) -> MathquadraticprogBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogBuffer::sum(self : MathquadraticprogBuffer) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogBuffer::mean(self : MathquadraticprogBuffer) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogBuffer::scale(self : MathquadraticprogBuffer, f : Double) -> MathquadraticprogBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogBuffer::add(self : MathquadraticprogBuffer, other : MathquadraticprogBuffer) -> MathquadraticprogBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogBuffer::copy(self : MathquadraticprogBuffer) -> MathquadraticprogBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogBuffer::fill(self : MathquadraticprogBuffer, v : Double) -> MathquadraticprogBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogBuffer::min(self : MathquadraticprogBuffer) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogBuffer::max(self : MathquadraticprogBuffer) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogBuffer::to_string(self : MathquadraticprogBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_cursor_make(size : Int) -> MathquadraticprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogCursor::len(self : MathquadraticprogCursor) -> Int { self.size }

pub fn MathquadraticprogCursor::get(self : MathquadraticprogCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogCursor::set(self : MathquadraticprogCursor, i : Int, v : Double) -> MathquadraticprogCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogCursor::sum(self : MathquadraticprogCursor) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogCursor::mean(self : MathquadraticprogCursor) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogCursor::scale(self : MathquadraticprogCursor, f : Double) -> MathquadraticprogCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogCursor::add(self : MathquadraticprogCursor, other : MathquadraticprogCursor) -> MathquadraticprogCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogCursor::copy(self : MathquadraticprogCursor) -> MathquadraticprogCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogCursor::fill(self : MathquadraticprogCursor, v : Double) -> MathquadraticprogCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogCursor::min(self : MathquadraticprogCursor) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogCursor::max(self : MathquadraticprogCursor) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogCursor::to_string(self : MathquadraticprogCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_view_make(size : Int) -> MathquadraticprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogView::len(self : MathquadraticprogView) -> Int { self.size }

pub fn MathquadraticprogView::get(self : MathquadraticprogView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogView::set(self : MathquadraticprogView, i : Int, v : Double) -> MathquadraticprogView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogView::sum(self : MathquadraticprogView) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogView::mean(self : MathquadraticprogView) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogView::scale(self : MathquadraticprogView, f : Double) -> MathquadraticprogView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogView::add(self : MathquadraticprogView, other : MathquadraticprogView) -> MathquadraticprogView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogView::copy(self : MathquadraticprogView) -> MathquadraticprogView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogView::fill(self : MathquadraticprogView, v : Double) -> MathquadraticprogView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogView::min(self : MathquadraticprogView) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogView::max(self : MathquadraticprogView) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogView::to_string(self : MathquadraticprogView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_range_make(size : Int) -> MathquadraticprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogRange::len(self : MathquadraticprogRange) -> Int { self.size }

pub fn MathquadraticprogRange::get(self : MathquadraticprogRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogRange::set(self : MathquadraticprogRange, i : Int, v : Double) -> MathquadraticprogRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogRange::sum(self : MathquadraticprogRange) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogRange::mean(self : MathquadraticprogRange) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogRange::scale(self : MathquadraticprogRange, f : Double) -> MathquadraticprogRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogRange::add(self : MathquadraticprogRange, other : MathquadraticprogRange) -> MathquadraticprogRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogRange::copy(self : MathquadraticprogRange) -> MathquadraticprogRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogRange::fill(self : MathquadraticprogRange, v : Double) -> MathquadraticprogRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogRange::min(self : MathquadraticprogRange) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogRange::max(self : MathquadraticprogRange) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogRange::to_string(self : MathquadraticprogRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_slice_make(size : Int) -> MathquadraticprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquadraticprogSlice::len(self : MathquadraticprogSlice) -> Int { self.size }

pub fn MathquadraticprogSlice::get(self : MathquadraticprogSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquadraticprogSlice::set(self : MathquadraticprogSlice, i : Int, v : Double) -> MathquadraticprogSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquadraticprogSlice::sum(self : MathquadraticprogSlice) -> Double { @_common.sum(self.data) }

pub fn MathquadraticprogSlice::mean(self : MathquadraticprogSlice) -> Double { @_common.mean(self.data) }

pub fn MathquadraticprogSlice::scale(self : MathquadraticprogSlice, f : Double) -> MathquadraticprogSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogSlice::add(self : MathquadraticprogSlice, other : MathquadraticprogSlice) -> MathquadraticprogSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquadraticprogSlice::copy(self : MathquadraticprogSlice) -> MathquadraticprogSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogSlice::fill(self : MathquadraticprogSlice, v : Double) -> MathquadraticprogSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquadraticprogSlice::min(self : MathquadraticprogSlice) -> Double { @_common.min(self.data) }

pub fn MathquadraticprogSlice::max(self : MathquadraticprogSlice) -> Double { @_common.max(self.data) }

pub fn MathquadraticprogSlice::to_string(self : MathquadraticprogSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

