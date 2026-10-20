///===
/// extcore/math_approx_chebyshev

pub(all) struct MathapproxchebyshevPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_chebyshev_make_point(x : Double, y : Double) -> MathapproxchebyshevPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_chebyshev_make_point3(x : Double, y : Double, z : Double) -> MathapproxchebyshevPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxchebyshevPoint::x(self : MathapproxchebyshevPoint) -> Double { self.x }

pub fn MathapproxchebyshevPoint::y(self : MathapproxchebyshevPoint) -> Double { self.y }

pub fn MathapproxchebyshevPoint::z(self : MathapproxchebyshevPoint) -> Double { self.z }

pub fn MathapproxchebyshevPoint::label(self : MathapproxchebyshevPoint) -> Int { self.label }

pub fn MathapproxchebyshevPoint::dist(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxchebyshevPoint::add(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxchebyshevPoint::sub(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxchebyshevPoint::scale(self : MathapproxchebyshevPoint, s : Double) -> MathapproxchebyshevPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxchebyshevPoint::dot(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxchebyshevPoint::cross(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxchebyshevPoint::norm(self : MathapproxchebyshevPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxchebyshevPoint::normalize(self : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxchebyshevPoint::negate(self : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxchebyshevPoint::mid(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxchebyshevPoint::lerp(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint, t : Double) -> MathapproxchebyshevPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxchebyshevPoint::to_string(self : MathapproxchebyshevPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxchebyshevSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_chebyshev_make_series(vals : Array[Double], name : String) -> MathapproxchebyshevSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxchebyshevSeries::len(self : MathapproxchebyshevSeries) -> Int { self.vals.length() }

pub fn MathapproxchebyshevSeries::sum(self : MathapproxchebyshevSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxchebyshevSeries::mean(self : MathapproxchebyshevSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxchebyshevSeries::min(self : MathapproxchebyshevSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxchebyshevSeries::max(self : MathapproxchebyshevSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxchebyshevSeries::range(self : MathapproxchebyshevSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxchebyshevSeries::variance(self : MathapproxchebyshevSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxchebyshevSeries::std(self : MathapproxchebyshevSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxchebyshevSeries::median(self : MathapproxchebyshevSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxchebyshevSeries::scale(self : MathapproxchebyshevSeries, f : Double) -> MathapproxchebyshevSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxchebyshevSeries::add(self : MathapproxchebyshevSeries, other : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxchebyshevSeries::sub(self : MathapproxchebyshevSeries, other : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxchebyshevSeries::normalize(self : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxchebyshevSeries::cumsum(self : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxchebyshevSeries::to_string(self : MathapproxchebyshevSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxchebyshevMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_chebyshev_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxchebyshevMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_approx_chebyshev_matrix_identity(n : Int) -> MathapproxchebyshevMatrix {
  let m = math_approx_chebyshev_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxchebyshevMatrix::get(self : MathapproxchebyshevMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxchebyshevMatrix::transpose(self : MathapproxchebyshevMatrix) -> MathapproxchebyshevMatrix {
  let result = math_approx_chebyshev_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxchebyshevMatrix::add(self : MathapproxchebyshevMatrix, other : MathapproxchebyshevMatrix) -> MathapproxchebyshevMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_chebyshev_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxchebyshevMatrix::scale(self : MathapproxchebyshevMatrix, s : Double) -> MathapproxchebyshevMatrix {
  let result = math_approx_chebyshev_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxchebyshevMatrix::multiply(self : MathapproxchebyshevMatrix, other : MathapproxchebyshevMatrix) -> MathapproxchebyshevMatrix {
  if self.cols != other.rows { return math_approx_chebyshev_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_chebyshev_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathapproxchebyshevMatrix::trace(self : MathapproxchebyshevMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxchebyshevMatrix::det(self : MathapproxchebyshevMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxchebyshevMatrix::norm(self : MathapproxchebyshevMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxchebyshevMatrix::to_string(self : MathapproxchebyshevMatrix) -> String {
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

pub(all) struct MathapproxchebyshevVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_chebyshev_make_vector(comps : Array[Double]) -> MathapproxchebyshevVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_chebyshev_vector_zero(dim : Int) -> MathapproxchebyshevVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxchebyshevVector::add(self : MathapproxchebyshevVector, other : MathapproxchebyshevVector) -> MathapproxchebyshevVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxchebyshevVector::sub(self : MathapproxchebyshevVector, other : MathapproxchebyshevVector) -> MathapproxchebyshevVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxchebyshevVector::scale(self : MathapproxchebyshevVector, s : Double) -> MathapproxchebyshevVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxchebyshevVector::dot(self : MathapproxchebyshevVector, other : MathapproxchebyshevVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxchebyshevVector::norm(self : MathapproxchebyshevVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxchebyshevVector::normalize(self : MathapproxchebyshevVector) -> MathapproxchebyshevVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxchebyshevVector::dist(self : MathapproxchebyshevVector, other : MathapproxchebyshevVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxchebyshevVector::to_string(self : MathapproxchebyshevVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxchebyshevFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_frame_make(size : Int) -> MathapproxchebyshevFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevFrame::len(self : MathapproxchebyshevFrame) -> Int { self.size }

pub fn MathapproxchebyshevFrame::get(self : MathapproxchebyshevFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevFrame::set(self : MathapproxchebyshevFrame, i : Int, v : Double) -> MathapproxchebyshevFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevFrame::sum(self : MathapproxchebyshevFrame) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevFrame::mean(self : MathapproxchebyshevFrame) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevFrame::scale(self : MathapproxchebyshevFrame, f : Double) -> MathapproxchebyshevFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevFrame::add(self : MathapproxchebyshevFrame, other : MathapproxchebyshevFrame) -> MathapproxchebyshevFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevFrame::copy(self : MathapproxchebyshevFrame) -> MathapproxchebyshevFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevFrame::fill(self : MathapproxchebyshevFrame, v : Double) -> MathapproxchebyshevFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevFrame::min(self : MathapproxchebyshevFrame) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevFrame::max(self : MathapproxchebyshevFrame) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevFrame::to_string(self : MathapproxchebyshevFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_table_make(size : Int) -> MathapproxchebyshevTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevTable::len(self : MathapproxchebyshevTable) -> Int { self.size }

pub fn MathapproxchebyshevTable::get(self : MathapproxchebyshevTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevTable::set(self : MathapproxchebyshevTable, i : Int, v : Double) -> MathapproxchebyshevTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevTable::sum(self : MathapproxchebyshevTable) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevTable::mean(self : MathapproxchebyshevTable) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevTable::scale(self : MathapproxchebyshevTable, f : Double) -> MathapproxchebyshevTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevTable::add(self : MathapproxchebyshevTable, other : MathapproxchebyshevTable) -> MathapproxchebyshevTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevTable::copy(self : MathapproxchebyshevTable) -> MathapproxchebyshevTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevTable::fill(self : MathapproxchebyshevTable, v : Double) -> MathapproxchebyshevTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevTable::min(self : MathapproxchebyshevTable) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevTable::max(self : MathapproxchebyshevTable) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevTable::to_string(self : MathapproxchebyshevTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_graphn_make(size : Int) -> MathapproxchebyshevGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevGraphN::len(self : MathapproxchebyshevGraphN) -> Int { self.size }

pub fn MathapproxchebyshevGraphN::get(self : MathapproxchebyshevGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevGraphN::set(self : MathapproxchebyshevGraphN, i : Int, v : Double) -> MathapproxchebyshevGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevGraphN::sum(self : MathapproxchebyshevGraphN) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevGraphN::mean(self : MathapproxchebyshevGraphN) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevGraphN::scale(self : MathapproxchebyshevGraphN, f : Double) -> MathapproxchebyshevGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevGraphN::add(self : MathapproxchebyshevGraphN, other : MathapproxchebyshevGraphN) -> MathapproxchebyshevGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevGraphN::copy(self : MathapproxchebyshevGraphN) -> MathapproxchebyshevGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevGraphN::fill(self : MathapproxchebyshevGraphN, v : Double) -> MathapproxchebyshevGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevGraphN::min(self : MathapproxchebyshevGraphN) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevGraphN::max(self : MathapproxchebyshevGraphN) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevGraphN::to_string(self : MathapproxchebyshevGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_node_make(size : Int) -> MathapproxchebyshevNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevNode::len(self : MathapproxchebyshevNode) -> Int { self.size }

pub fn MathapproxchebyshevNode::get(self : MathapproxchebyshevNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevNode::set(self : MathapproxchebyshevNode, i : Int, v : Double) -> MathapproxchebyshevNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevNode::sum(self : MathapproxchebyshevNode) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevNode::mean(self : MathapproxchebyshevNode) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevNode::scale(self : MathapproxchebyshevNode, f : Double) -> MathapproxchebyshevNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevNode::add(self : MathapproxchebyshevNode, other : MathapproxchebyshevNode) -> MathapproxchebyshevNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevNode::copy(self : MathapproxchebyshevNode) -> MathapproxchebyshevNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevNode::fill(self : MathapproxchebyshevNode, v : Double) -> MathapproxchebyshevNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevNode::min(self : MathapproxchebyshevNode) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevNode::max(self : MathapproxchebyshevNode) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevNode::to_string(self : MathapproxchebyshevNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_edge_make(size : Int) -> MathapproxchebyshevEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevEdge::len(self : MathapproxchebyshevEdge) -> Int { self.size }

pub fn MathapproxchebyshevEdge::get(self : MathapproxchebyshevEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevEdge::set(self : MathapproxchebyshevEdge, i : Int, v : Double) -> MathapproxchebyshevEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevEdge::sum(self : MathapproxchebyshevEdge) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevEdge::mean(self : MathapproxchebyshevEdge) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevEdge::scale(self : MathapproxchebyshevEdge, f : Double) -> MathapproxchebyshevEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevEdge::add(self : MathapproxchebyshevEdge, other : MathapproxchebyshevEdge) -> MathapproxchebyshevEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevEdge::copy(self : MathapproxchebyshevEdge) -> MathapproxchebyshevEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevEdge::fill(self : MathapproxchebyshevEdge, v : Double) -> MathapproxchebyshevEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevEdge::min(self : MathapproxchebyshevEdge) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevEdge::max(self : MathapproxchebyshevEdge) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevEdge::to_string(self : MathapproxchebyshevEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_path_make(size : Int) -> MathapproxchebyshevPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevPath::len(self : MathapproxchebyshevPath) -> Int { self.size }

pub fn MathapproxchebyshevPath::get(self : MathapproxchebyshevPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevPath::set(self : MathapproxchebyshevPath, i : Int, v : Double) -> MathapproxchebyshevPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevPath::sum(self : MathapproxchebyshevPath) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevPath::mean(self : MathapproxchebyshevPath) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevPath::scale(self : MathapproxchebyshevPath, f : Double) -> MathapproxchebyshevPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevPath::add(self : MathapproxchebyshevPath, other : MathapproxchebyshevPath) -> MathapproxchebyshevPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevPath::copy(self : MathapproxchebyshevPath) -> MathapproxchebyshevPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevPath::fill(self : MathapproxchebyshevPath, v : Double) -> MathapproxchebyshevPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevPath::min(self : MathapproxchebyshevPath) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevPath::max(self : MathapproxchebyshevPath) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevPath::to_string(self : MathapproxchebyshevPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_cluster_make(size : Int) -> MathapproxchebyshevCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevCluster::len(self : MathapproxchebyshevCluster) -> Int { self.size }

pub fn MathapproxchebyshevCluster::get(self : MathapproxchebyshevCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevCluster::set(self : MathapproxchebyshevCluster, i : Int, v : Double) -> MathapproxchebyshevCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevCluster::sum(self : MathapproxchebyshevCluster) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevCluster::mean(self : MathapproxchebyshevCluster) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevCluster::scale(self : MathapproxchebyshevCluster, f : Double) -> MathapproxchebyshevCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevCluster::add(self : MathapproxchebyshevCluster, other : MathapproxchebyshevCluster) -> MathapproxchebyshevCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevCluster::copy(self : MathapproxchebyshevCluster) -> MathapproxchebyshevCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevCluster::fill(self : MathapproxchebyshevCluster, v : Double) -> MathapproxchebyshevCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevCluster::min(self : MathapproxchebyshevCluster) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevCluster::max(self : MathapproxchebyshevCluster) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevCluster::to_string(self : MathapproxchebyshevCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_model_make(size : Int) -> MathapproxchebyshevModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevModel::len(self : MathapproxchebyshevModel) -> Int { self.size }

pub fn MathapproxchebyshevModel::get(self : MathapproxchebyshevModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevModel::set(self : MathapproxchebyshevModel, i : Int, v : Double) -> MathapproxchebyshevModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevModel::sum(self : MathapproxchebyshevModel) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevModel::mean(self : MathapproxchebyshevModel) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevModel::scale(self : MathapproxchebyshevModel, f : Double) -> MathapproxchebyshevModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevModel::add(self : MathapproxchebyshevModel, other : MathapproxchebyshevModel) -> MathapproxchebyshevModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevModel::copy(self : MathapproxchebyshevModel) -> MathapproxchebyshevModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevModel::fill(self : MathapproxchebyshevModel, v : Double) -> MathapproxchebyshevModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevModel::min(self : MathapproxchebyshevModel) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevModel::max(self : MathapproxchebyshevModel) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevModel::to_string(self : MathapproxchebyshevModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_layer_make(size : Int) -> MathapproxchebyshevLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevLayer::len(self : MathapproxchebyshevLayer) -> Int { self.size }

pub fn MathapproxchebyshevLayer::get(self : MathapproxchebyshevLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevLayer::set(self : MathapproxchebyshevLayer, i : Int, v : Double) -> MathapproxchebyshevLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevLayer::sum(self : MathapproxchebyshevLayer) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevLayer::mean(self : MathapproxchebyshevLayer) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevLayer::scale(self : MathapproxchebyshevLayer, f : Double) -> MathapproxchebyshevLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevLayer::add(self : MathapproxchebyshevLayer, other : MathapproxchebyshevLayer) -> MathapproxchebyshevLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevLayer::copy(self : MathapproxchebyshevLayer) -> MathapproxchebyshevLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevLayer::fill(self : MathapproxchebyshevLayer, v : Double) -> MathapproxchebyshevLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevLayer::min(self : MathapproxchebyshevLayer) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevLayer::max(self : MathapproxchebyshevLayer) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevLayer::to_string(self : MathapproxchebyshevLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_buffer_make(size : Int) -> MathapproxchebyshevBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevBuffer::len(self : MathapproxchebyshevBuffer) -> Int { self.size }

pub fn MathapproxchebyshevBuffer::get(self : MathapproxchebyshevBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevBuffer::set(self : MathapproxchebyshevBuffer, i : Int, v : Double) -> MathapproxchebyshevBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevBuffer::sum(self : MathapproxchebyshevBuffer) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevBuffer::mean(self : MathapproxchebyshevBuffer) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevBuffer::scale(self : MathapproxchebyshevBuffer, f : Double) -> MathapproxchebyshevBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevBuffer::add(self : MathapproxchebyshevBuffer, other : MathapproxchebyshevBuffer) -> MathapproxchebyshevBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevBuffer::copy(self : MathapproxchebyshevBuffer) -> MathapproxchebyshevBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevBuffer::fill(self : MathapproxchebyshevBuffer, v : Double) -> MathapproxchebyshevBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevBuffer::min(self : MathapproxchebyshevBuffer) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevBuffer::max(self : MathapproxchebyshevBuffer) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevBuffer::to_string(self : MathapproxchebyshevBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_cursor_make(size : Int) -> MathapproxchebyshevCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevCursor::len(self : MathapproxchebyshevCursor) -> Int { self.size }

pub fn MathapproxchebyshevCursor::get(self : MathapproxchebyshevCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevCursor::set(self : MathapproxchebyshevCursor, i : Int, v : Double) -> MathapproxchebyshevCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevCursor::sum(self : MathapproxchebyshevCursor) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevCursor::mean(self : MathapproxchebyshevCursor) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevCursor::scale(self : MathapproxchebyshevCursor, f : Double) -> MathapproxchebyshevCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevCursor::add(self : MathapproxchebyshevCursor, other : MathapproxchebyshevCursor) -> MathapproxchebyshevCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevCursor::copy(self : MathapproxchebyshevCursor) -> MathapproxchebyshevCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevCursor::fill(self : MathapproxchebyshevCursor, v : Double) -> MathapproxchebyshevCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevCursor::min(self : MathapproxchebyshevCursor) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevCursor::max(self : MathapproxchebyshevCursor) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevCursor::to_string(self : MathapproxchebyshevCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_view_make(size : Int) -> MathapproxchebyshevView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevView::len(self : MathapproxchebyshevView) -> Int { self.size }

pub fn MathapproxchebyshevView::get(self : MathapproxchebyshevView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevView::set(self : MathapproxchebyshevView, i : Int, v : Double) -> MathapproxchebyshevView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevView::sum(self : MathapproxchebyshevView) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevView::mean(self : MathapproxchebyshevView) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevView::scale(self : MathapproxchebyshevView, f : Double) -> MathapproxchebyshevView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevView::add(self : MathapproxchebyshevView, other : MathapproxchebyshevView) -> MathapproxchebyshevView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevView::copy(self : MathapproxchebyshevView) -> MathapproxchebyshevView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevView::fill(self : MathapproxchebyshevView, v : Double) -> MathapproxchebyshevView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevView::min(self : MathapproxchebyshevView) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevView::max(self : MathapproxchebyshevView) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevView::to_string(self : MathapproxchebyshevView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_range_make(size : Int) -> MathapproxchebyshevRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevRange::len(self : MathapproxchebyshevRange) -> Int { self.size }

pub fn MathapproxchebyshevRange::get(self : MathapproxchebyshevRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevRange::set(self : MathapproxchebyshevRange, i : Int, v : Double) -> MathapproxchebyshevRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevRange::sum(self : MathapproxchebyshevRange) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevRange::mean(self : MathapproxchebyshevRange) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevRange::scale(self : MathapproxchebyshevRange, f : Double) -> MathapproxchebyshevRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevRange::add(self : MathapproxchebyshevRange, other : MathapproxchebyshevRange) -> MathapproxchebyshevRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevRange::copy(self : MathapproxchebyshevRange) -> MathapproxchebyshevRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevRange::fill(self : MathapproxchebyshevRange, v : Double) -> MathapproxchebyshevRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevRange::min(self : MathapproxchebyshevRange) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevRange::max(self : MathapproxchebyshevRange) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevRange::to_string(self : MathapproxchebyshevRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_slice_make(size : Int) -> MathapproxchebyshevSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxchebyshevSlice::len(self : MathapproxchebyshevSlice) -> Int { self.size }

pub fn MathapproxchebyshevSlice::get(self : MathapproxchebyshevSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxchebyshevSlice::set(self : MathapproxchebyshevSlice, i : Int, v : Double) -> MathapproxchebyshevSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevSlice::sum(self : MathapproxchebyshevSlice) -> Double { @_common.sum(self.data) }

pub fn MathapproxchebyshevSlice::mean(self : MathapproxchebyshevSlice) -> Double { @_common.mean(self.data) }

pub fn MathapproxchebyshevSlice::scale(self : MathapproxchebyshevSlice, f : Double) -> MathapproxchebyshevSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevSlice::add(self : MathapproxchebyshevSlice, other : MathapproxchebyshevSlice) -> MathapproxchebyshevSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxchebyshevSlice::copy(self : MathapproxchebyshevSlice) -> MathapproxchebyshevSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevSlice::fill(self : MathapproxchebyshevSlice, v : Double) -> MathapproxchebyshevSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxchebyshevSlice::min(self : MathapproxchebyshevSlice) -> Double { @_common.min(self.data) }

pub fn MathapproxchebyshevSlice::max(self : MathapproxchebyshevSlice) -> Double { @_common.max(self.data) }

pub fn MathapproxchebyshevSlice::to_string(self : MathapproxchebyshevSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

