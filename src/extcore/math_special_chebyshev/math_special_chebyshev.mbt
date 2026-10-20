///===
/// extcore/math_special_chebyshev

pub(all) struct MathspecialchebyshevPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_chebyshev_make_point(x : Double, y : Double) -> MathspecialchebyshevPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_chebyshev_make_point3(x : Double, y : Double, z : Double) -> MathspecialchebyshevPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialchebyshevPoint::x(self : MathspecialchebyshevPoint) -> Double { self.x }

pub fn MathspecialchebyshevPoint::y(self : MathspecialchebyshevPoint) -> Double { self.y }

pub fn MathspecialchebyshevPoint::z(self : MathspecialchebyshevPoint) -> Double { self.z }

pub fn MathspecialchebyshevPoint::label(self : MathspecialchebyshevPoint) -> Int { self.label }

pub fn MathspecialchebyshevPoint::dist(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialchebyshevPoint::add(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialchebyshevPoint::sub(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialchebyshevPoint::scale(self : MathspecialchebyshevPoint, s : Double) -> MathspecialchebyshevPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialchebyshevPoint::dot(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialchebyshevPoint::cross(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialchebyshevPoint::norm(self : MathspecialchebyshevPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialchebyshevPoint::normalize(self : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialchebyshevPoint::negate(self : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialchebyshevPoint::mid(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialchebyshevPoint::lerp(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint, t : Double) -> MathspecialchebyshevPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialchebyshevPoint::to_string(self : MathspecialchebyshevPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialchebyshevSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_chebyshev_make_series(vals : Array[Double], name : String) -> MathspecialchebyshevSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialchebyshevSeries::len(self : MathspecialchebyshevSeries) -> Int { self.vals.length() }

pub fn MathspecialchebyshevSeries::sum(self : MathspecialchebyshevSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialchebyshevSeries::mean(self : MathspecialchebyshevSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialchebyshevSeries::min(self : MathspecialchebyshevSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialchebyshevSeries::max(self : MathspecialchebyshevSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialchebyshevSeries::range(self : MathspecialchebyshevSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialchebyshevSeries::variance(self : MathspecialchebyshevSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialchebyshevSeries::std(self : MathspecialchebyshevSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialchebyshevSeries::median(self : MathspecialchebyshevSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialchebyshevSeries::scale(self : MathspecialchebyshevSeries, f : Double) -> MathspecialchebyshevSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialchebyshevSeries::add(self : MathspecialchebyshevSeries, other : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialchebyshevSeries::sub(self : MathspecialchebyshevSeries, other : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialchebyshevSeries::normalize(self : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialchebyshevSeries::cumsum(self : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialchebyshevSeries::to_string(self : MathspecialchebyshevSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialchebyshevMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_chebyshev_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialchebyshevMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_special_chebyshev_matrix_identity(n : Int) -> MathspecialchebyshevMatrix {
  let m = math_special_chebyshev_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialchebyshevMatrix::get(self : MathspecialchebyshevMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialchebyshevMatrix::transpose(self : MathspecialchebyshevMatrix) -> MathspecialchebyshevMatrix {
  let result = math_special_chebyshev_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialchebyshevMatrix::add(self : MathspecialchebyshevMatrix, other : MathspecialchebyshevMatrix) -> MathspecialchebyshevMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_chebyshev_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialchebyshevMatrix::scale(self : MathspecialchebyshevMatrix, s : Double) -> MathspecialchebyshevMatrix {
  let result = math_special_chebyshev_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialchebyshevMatrix::multiply(self : MathspecialchebyshevMatrix, other : MathspecialchebyshevMatrix) -> MathspecialchebyshevMatrix {
  if self.cols != other.rows { return math_special_chebyshev_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_chebyshev_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathspecialchebyshevMatrix::trace(self : MathspecialchebyshevMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialchebyshevMatrix::det(self : MathspecialchebyshevMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialchebyshevMatrix::norm(self : MathspecialchebyshevMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialchebyshevMatrix::to_string(self : MathspecialchebyshevMatrix) -> String {
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

pub(all) struct MathspecialchebyshevVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_chebyshev_make_vector(comps : Array[Double]) -> MathspecialchebyshevVector {
  { comps, dim: comps.length() }
}

pub fn math_special_chebyshev_vector_zero(dim : Int) -> MathspecialchebyshevVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialchebyshevVector::add(self : MathspecialchebyshevVector, other : MathspecialchebyshevVector) -> MathspecialchebyshevVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialchebyshevVector::sub(self : MathspecialchebyshevVector, other : MathspecialchebyshevVector) -> MathspecialchebyshevVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialchebyshevVector::scale(self : MathspecialchebyshevVector, s : Double) -> MathspecialchebyshevVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialchebyshevVector::dot(self : MathspecialchebyshevVector, other : MathspecialchebyshevVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialchebyshevVector::norm(self : MathspecialchebyshevVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialchebyshevVector::normalize(self : MathspecialchebyshevVector) -> MathspecialchebyshevVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialchebyshevVector::dist(self : MathspecialchebyshevVector, other : MathspecialchebyshevVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialchebyshevVector::to_string(self : MathspecialchebyshevVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialchebyshevFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_frame_make(size : Int) -> MathspecialchebyshevFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevFrame::len(self : MathspecialchebyshevFrame) -> Int { self.size }

pub fn MathspecialchebyshevFrame::get(self : MathspecialchebyshevFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevFrame::set(self : MathspecialchebyshevFrame, i : Int, v : Double) -> MathspecialchebyshevFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevFrame::sum(self : MathspecialchebyshevFrame) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevFrame::mean(self : MathspecialchebyshevFrame) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevFrame::scale(self : MathspecialchebyshevFrame, f : Double) -> MathspecialchebyshevFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevFrame::add(self : MathspecialchebyshevFrame, other : MathspecialchebyshevFrame) -> MathspecialchebyshevFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevFrame::copy(self : MathspecialchebyshevFrame) -> MathspecialchebyshevFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevFrame::fill(self : MathspecialchebyshevFrame, v : Double) -> MathspecialchebyshevFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevFrame::min(self : MathspecialchebyshevFrame) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevFrame::max(self : MathspecialchebyshevFrame) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevFrame::to_string(self : MathspecialchebyshevFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_table_make(size : Int) -> MathspecialchebyshevTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevTable::len(self : MathspecialchebyshevTable) -> Int { self.size }

pub fn MathspecialchebyshevTable::get(self : MathspecialchebyshevTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevTable::set(self : MathspecialchebyshevTable, i : Int, v : Double) -> MathspecialchebyshevTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevTable::sum(self : MathspecialchebyshevTable) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevTable::mean(self : MathspecialchebyshevTable) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevTable::scale(self : MathspecialchebyshevTable, f : Double) -> MathspecialchebyshevTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevTable::add(self : MathspecialchebyshevTable, other : MathspecialchebyshevTable) -> MathspecialchebyshevTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevTable::copy(self : MathspecialchebyshevTable) -> MathspecialchebyshevTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevTable::fill(self : MathspecialchebyshevTable, v : Double) -> MathspecialchebyshevTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevTable::min(self : MathspecialchebyshevTable) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevTable::max(self : MathspecialchebyshevTable) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevTable::to_string(self : MathspecialchebyshevTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_graphn_make(size : Int) -> MathspecialchebyshevGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevGraphN::len(self : MathspecialchebyshevGraphN) -> Int { self.size }

pub fn MathspecialchebyshevGraphN::get(self : MathspecialchebyshevGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevGraphN::set(self : MathspecialchebyshevGraphN, i : Int, v : Double) -> MathspecialchebyshevGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevGraphN::sum(self : MathspecialchebyshevGraphN) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevGraphN::mean(self : MathspecialchebyshevGraphN) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevGraphN::scale(self : MathspecialchebyshevGraphN, f : Double) -> MathspecialchebyshevGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevGraphN::add(self : MathspecialchebyshevGraphN, other : MathspecialchebyshevGraphN) -> MathspecialchebyshevGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevGraphN::copy(self : MathspecialchebyshevGraphN) -> MathspecialchebyshevGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevGraphN::fill(self : MathspecialchebyshevGraphN, v : Double) -> MathspecialchebyshevGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevGraphN::min(self : MathspecialchebyshevGraphN) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevGraphN::max(self : MathspecialchebyshevGraphN) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevGraphN::to_string(self : MathspecialchebyshevGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_node_make(size : Int) -> MathspecialchebyshevNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevNode::len(self : MathspecialchebyshevNode) -> Int { self.size }

pub fn MathspecialchebyshevNode::get(self : MathspecialchebyshevNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevNode::set(self : MathspecialchebyshevNode, i : Int, v : Double) -> MathspecialchebyshevNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevNode::sum(self : MathspecialchebyshevNode) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevNode::mean(self : MathspecialchebyshevNode) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevNode::scale(self : MathspecialchebyshevNode, f : Double) -> MathspecialchebyshevNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevNode::add(self : MathspecialchebyshevNode, other : MathspecialchebyshevNode) -> MathspecialchebyshevNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevNode::copy(self : MathspecialchebyshevNode) -> MathspecialchebyshevNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevNode::fill(self : MathspecialchebyshevNode, v : Double) -> MathspecialchebyshevNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevNode::min(self : MathspecialchebyshevNode) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevNode::max(self : MathspecialchebyshevNode) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevNode::to_string(self : MathspecialchebyshevNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_edge_make(size : Int) -> MathspecialchebyshevEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevEdge::len(self : MathspecialchebyshevEdge) -> Int { self.size }

pub fn MathspecialchebyshevEdge::get(self : MathspecialchebyshevEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevEdge::set(self : MathspecialchebyshevEdge, i : Int, v : Double) -> MathspecialchebyshevEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevEdge::sum(self : MathspecialchebyshevEdge) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevEdge::mean(self : MathspecialchebyshevEdge) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevEdge::scale(self : MathspecialchebyshevEdge, f : Double) -> MathspecialchebyshevEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevEdge::add(self : MathspecialchebyshevEdge, other : MathspecialchebyshevEdge) -> MathspecialchebyshevEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevEdge::copy(self : MathspecialchebyshevEdge) -> MathspecialchebyshevEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevEdge::fill(self : MathspecialchebyshevEdge, v : Double) -> MathspecialchebyshevEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevEdge::min(self : MathspecialchebyshevEdge) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevEdge::max(self : MathspecialchebyshevEdge) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevEdge::to_string(self : MathspecialchebyshevEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_path_make(size : Int) -> MathspecialchebyshevPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevPath::len(self : MathspecialchebyshevPath) -> Int { self.size }

pub fn MathspecialchebyshevPath::get(self : MathspecialchebyshevPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevPath::set(self : MathspecialchebyshevPath, i : Int, v : Double) -> MathspecialchebyshevPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevPath::sum(self : MathspecialchebyshevPath) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevPath::mean(self : MathspecialchebyshevPath) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevPath::scale(self : MathspecialchebyshevPath, f : Double) -> MathspecialchebyshevPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevPath::add(self : MathspecialchebyshevPath, other : MathspecialchebyshevPath) -> MathspecialchebyshevPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevPath::copy(self : MathspecialchebyshevPath) -> MathspecialchebyshevPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevPath::fill(self : MathspecialchebyshevPath, v : Double) -> MathspecialchebyshevPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevPath::min(self : MathspecialchebyshevPath) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevPath::max(self : MathspecialchebyshevPath) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevPath::to_string(self : MathspecialchebyshevPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_cluster_make(size : Int) -> MathspecialchebyshevCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevCluster::len(self : MathspecialchebyshevCluster) -> Int { self.size }

pub fn MathspecialchebyshevCluster::get(self : MathspecialchebyshevCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevCluster::set(self : MathspecialchebyshevCluster, i : Int, v : Double) -> MathspecialchebyshevCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevCluster::sum(self : MathspecialchebyshevCluster) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevCluster::mean(self : MathspecialchebyshevCluster) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevCluster::scale(self : MathspecialchebyshevCluster, f : Double) -> MathspecialchebyshevCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevCluster::add(self : MathspecialchebyshevCluster, other : MathspecialchebyshevCluster) -> MathspecialchebyshevCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevCluster::copy(self : MathspecialchebyshevCluster) -> MathspecialchebyshevCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevCluster::fill(self : MathspecialchebyshevCluster, v : Double) -> MathspecialchebyshevCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevCluster::min(self : MathspecialchebyshevCluster) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevCluster::max(self : MathspecialchebyshevCluster) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevCluster::to_string(self : MathspecialchebyshevCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_model_make(size : Int) -> MathspecialchebyshevModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevModel::len(self : MathspecialchebyshevModel) -> Int { self.size }

pub fn MathspecialchebyshevModel::get(self : MathspecialchebyshevModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevModel::set(self : MathspecialchebyshevModel, i : Int, v : Double) -> MathspecialchebyshevModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevModel::sum(self : MathspecialchebyshevModel) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevModel::mean(self : MathspecialchebyshevModel) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevModel::scale(self : MathspecialchebyshevModel, f : Double) -> MathspecialchebyshevModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevModel::add(self : MathspecialchebyshevModel, other : MathspecialchebyshevModel) -> MathspecialchebyshevModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevModel::copy(self : MathspecialchebyshevModel) -> MathspecialchebyshevModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevModel::fill(self : MathspecialchebyshevModel, v : Double) -> MathspecialchebyshevModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevModel::min(self : MathspecialchebyshevModel) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevModel::max(self : MathspecialchebyshevModel) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevModel::to_string(self : MathspecialchebyshevModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_layer_make(size : Int) -> MathspecialchebyshevLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevLayer::len(self : MathspecialchebyshevLayer) -> Int { self.size }

pub fn MathspecialchebyshevLayer::get(self : MathspecialchebyshevLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevLayer::set(self : MathspecialchebyshevLayer, i : Int, v : Double) -> MathspecialchebyshevLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevLayer::sum(self : MathspecialchebyshevLayer) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevLayer::mean(self : MathspecialchebyshevLayer) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevLayer::scale(self : MathspecialchebyshevLayer, f : Double) -> MathspecialchebyshevLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevLayer::add(self : MathspecialchebyshevLayer, other : MathspecialchebyshevLayer) -> MathspecialchebyshevLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevLayer::copy(self : MathspecialchebyshevLayer) -> MathspecialchebyshevLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevLayer::fill(self : MathspecialchebyshevLayer, v : Double) -> MathspecialchebyshevLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevLayer::min(self : MathspecialchebyshevLayer) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevLayer::max(self : MathspecialchebyshevLayer) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevLayer::to_string(self : MathspecialchebyshevLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_buffer_make(size : Int) -> MathspecialchebyshevBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevBuffer::len(self : MathspecialchebyshevBuffer) -> Int { self.size }

pub fn MathspecialchebyshevBuffer::get(self : MathspecialchebyshevBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevBuffer::set(self : MathspecialchebyshevBuffer, i : Int, v : Double) -> MathspecialchebyshevBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevBuffer::sum(self : MathspecialchebyshevBuffer) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevBuffer::mean(self : MathspecialchebyshevBuffer) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevBuffer::scale(self : MathspecialchebyshevBuffer, f : Double) -> MathspecialchebyshevBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevBuffer::add(self : MathspecialchebyshevBuffer, other : MathspecialchebyshevBuffer) -> MathspecialchebyshevBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevBuffer::copy(self : MathspecialchebyshevBuffer) -> MathspecialchebyshevBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevBuffer::fill(self : MathspecialchebyshevBuffer, v : Double) -> MathspecialchebyshevBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevBuffer::min(self : MathspecialchebyshevBuffer) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevBuffer::max(self : MathspecialchebyshevBuffer) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevBuffer::to_string(self : MathspecialchebyshevBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_cursor_make(size : Int) -> MathspecialchebyshevCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevCursor::len(self : MathspecialchebyshevCursor) -> Int { self.size }

pub fn MathspecialchebyshevCursor::get(self : MathspecialchebyshevCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevCursor::set(self : MathspecialchebyshevCursor, i : Int, v : Double) -> MathspecialchebyshevCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevCursor::sum(self : MathspecialchebyshevCursor) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevCursor::mean(self : MathspecialchebyshevCursor) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevCursor::scale(self : MathspecialchebyshevCursor, f : Double) -> MathspecialchebyshevCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevCursor::add(self : MathspecialchebyshevCursor, other : MathspecialchebyshevCursor) -> MathspecialchebyshevCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevCursor::copy(self : MathspecialchebyshevCursor) -> MathspecialchebyshevCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevCursor::fill(self : MathspecialchebyshevCursor, v : Double) -> MathspecialchebyshevCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevCursor::min(self : MathspecialchebyshevCursor) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevCursor::max(self : MathspecialchebyshevCursor) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevCursor::to_string(self : MathspecialchebyshevCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_view_make(size : Int) -> MathspecialchebyshevView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevView::len(self : MathspecialchebyshevView) -> Int { self.size }

pub fn MathspecialchebyshevView::get(self : MathspecialchebyshevView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevView::set(self : MathspecialchebyshevView, i : Int, v : Double) -> MathspecialchebyshevView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevView::sum(self : MathspecialchebyshevView) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevView::mean(self : MathspecialchebyshevView) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevView::scale(self : MathspecialchebyshevView, f : Double) -> MathspecialchebyshevView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevView::add(self : MathspecialchebyshevView, other : MathspecialchebyshevView) -> MathspecialchebyshevView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevView::copy(self : MathspecialchebyshevView) -> MathspecialchebyshevView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevView::fill(self : MathspecialchebyshevView, v : Double) -> MathspecialchebyshevView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevView::min(self : MathspecialchebyshevView) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevView::max(self : MathspecialchebyshevView) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevView::to_string(self : MathspecialchebyshevView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_range_make(size : Int) -> MathspecialchebyshevRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevRange::len(self : MathspecialchebyshevRange) -> Int { self.size }

pub fn MathspecialchebyshevRange::get(self : MathspecialchebyshevRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevRange::set(self : MathspecialchebyshevRange, i : Int, v : Double) -> MathspecialchebyshevRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevRange::sum(self : MathspecialchebyshevRange) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevRange::mean(self : MathspecialchebyshevRange) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevRange::scale(self : MathspecialchebyshevRange, f : Double) -> MathspecialchebyshevRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevRange::add(self : MathspecialchebyshevRange, other : MathspecialchebyshevRange) -> MathspecialchebyshevRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevRange::copy(self : MathspecialchebyshevRange) -> MathspecialchebyshevRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevRange::fill(self : MathspecialchebyshevRange, v : Double) -> MathspecialchebyshevRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevRange::min(self : MathspecialchebyshevRange) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevRange::max(self : MathspecialchebyshevRange) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevRange::to_string(self : MathspecialchebyshevRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_slice_make(size : Int) -> MathspecialchebyshevSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialchebyshevSlice::len(self : MathspecialchebyshevSlice) -> Int { self.size }

pub fn MathspecialchebyshevSlice::get(self : MathspecialchebyshevSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialchebyshevSlice::set(self : MathspecialchebyshevSlice, i : Int, v : Double) -> MathspecialchebyshevSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevSlice::sum(self : MathspecialchebyshevSlice) -> Double { @_common.sum(self.data) }

pub fn MathspecialchebyshevSlice::mean(self : MathspecialchebyshevSlice) -> Double { @_common.mean(self.data) }

pub fn MathspecialchebyshevSlice::scale(self : MathspecialchebyshevSlice, f : Double) -> MathspecialchebyshevSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevSlice::add(self : MathspecialchebyshevSlice, other : MathspecialchebyshevSlice) -> MathspecialchebyshevSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialchebyshevSlice::copy(self : MathspecialchebyshevSlice) -> MathspecialchebyshevSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevSlice::fill(self : MathspecialchebyshevSlice, v : Double) -> MathspecialchebyshevSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialchebyshevSlice::min(self : MathspecialchebyshevSlice) -> Double { @_common.min(self.data) }

pub fn MathspecialchebyshevSlice::max(self : MathspecialchebyshevSlice) -> Double { @_common.max(self.data) }

pub fn MathspecialchebyshevSlice::to_string(self : MathspecialchebyshevSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

