///===
/// extcore/finance_pricing_barrier

pub(all) struct FinancepricingbarrierPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_barrier_make_point(x : Double, y : Double) -> FinancepricingbarrierPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_barrier_make_point3(x : Double, y : Double, z : Double) -> FinancepricingbarrierPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingbarrierPoint::x(self : FinancepricingbarrierPoint) -> Double { self.x }

pub fn FinancepricingbarrierPoint::y(self : FinancepricingbarrierPoint) -> Double { self.y }

pub fn FinancepricingbarrierPoint::z(self : FinancepricingbarrierPoint) -> Double { self.z }

pub fn FinancepricingbarrierPoint::label(self : FinancepricingbarrierPoint) -> Int { self.label }

pub fn FinancepricingbarrierPoint::dist(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingbarrierPoint::add(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingbarrierPoint::sub(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingbarrierPoint::scale(self : FinancepricingbarrierPoint, s : Double) -> FinancepricingbarrierPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingbarrierPoint::dot(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingbarrierPoint::cross(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingbarrierPoint::norm(self : FinancepricingbarrierPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingbarrierPoint::normalize(self : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbarrierPoint::negate(self : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingbarrierPoint::mid(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingbarrierPoint::lerp(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint, t : Double) -> FinancepricingbarrierPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingbarrierPoint::to_string(self : FinancepricingbarrierPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingbarrierSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_barrier_make_series(vals : Array[Double], name : String) -> FinancepricingbarrierSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingbarrierSeries::len(self : FinancepricingbarrierSeries) -> Int { self.vals.length() }

pub fn FinancepricingbarrierSeries::sum(self : FinancepricingbarrierSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingbarrierSeries::mean(self : FinancepricingbarrierSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingbarrierSeries::min(self : FinancepricingbarrierSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingbarrierSeries::max(self : FinancepricingbarrierSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingbarrierSeries::range(self : FinancepricingbarrierSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingbarrierSeries::variance(self : FinancepricingbarrierSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingbarrierSeries::std(self : FinancepricingbarrierSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingbarrierSeries::median(self : FinancepricingbarrierSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingbarrierSeries::scale(self : FinancepricingbarrierSeries, f : Double) -> FinancepricingbarrierSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingbarrierSeries::add(self : FinancepricingbarrierSeries, other : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingbarrierSeries::sub(self : FinancepricingbarrierSeries, other : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingbarrierSeries::normalize(self : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingbarrierSeries::cumsum(self : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingbarrierSeries::to_string(self : FinancepricingbarrierSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbarrierMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_barrier_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingbarrierMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_barrier_matrix_identity(n : Int) -> FinancepricingbarrierMatrix {
  let m = finance_pricing_barrier_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingbarrierMatrix::get(self : FinancepricingbarrierMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingbarrierMatrix::transpose(self : FinancepricingbarrierMatrix) -> FinancepricingbarrierMatrix {
  let result = finance_pricing_barrier_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingbarrierMatrix::add(self : FinancepricingbarrierMatrix, other : FinancepricingbarrierMatrix) -> FinancepricingbarrierMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_barrier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingbarrierMatrix::scale(self : FinancepricingbarrierMatrix, s : Double) -> FinancepricingbarrierMatrix {
  let result = finance_pricing_barrier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingbarrierMatrix::multiply(self : FinancepricingbarrierMatrix, other : FinancepricingbarrierMatrix) -> FinancepricingbarrierMatrix {
  if self.cols != other.rows { return finance_pricing_barrier_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_barrier_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingbarrierMatrix::trace(self : FinancepricingbarrierMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingbarrierMatrix::det(self : FinancepricingbarrierMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingbarrierMatrix::norm(self : FinancepricingbarrierMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingbarrierMatrix::to_string(self : FinancepricingbarrierMatrix) -> String {
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

pub(all) struct FinancepricingbarrierVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_barrier_make_vector(comps : Array[Double]) -> FinancepricingbarrierVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_barrier_vector_zero(dim : Int) -> FinancepricingbarrierVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingbarrierVector::add(self : FinancepricingbarrierVector, other : FinancepricingbarrierVector) -> FinancepricingbarrierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbarrierVector::sub(self : FinancepricingbarrierVector, other : FinancepricingbarrierVector) -> FinancepricingbarrierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbarrierVector::scale(self : FinancepricingbarrierVector, s : Double) -> FinancepricingbarrierVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingbarrierVector::dot(self : FinancepricingbarrierVector, other : FinancepricingbarrierVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingbarrierVector::norm(self : FinancepricingbarrierVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingbarrierVector::normalize(self : FinancepricingbarrierVector) -> FinancepricingbarrierVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbarrierVector::dist(self : FinancepricingbarrierVector, other : FinancepricingbarrierVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingbarrierVector::to_string(self : FinancepricingbarrierVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbarrierFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_frame_make(size : Int) -> FinancepricingbarrierFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierFrame::len(self : FinancepricingbarrierFrame) -> Int { self.size }

pub fn FinancepricingbarrierFrame::get(self : FinancepricingbarrierFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierFrame::set(self : FinancepricingbarrierFrame, i : Int, v : Double) -> FinancepricingbarrierFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierFrame::sum(self : FinancepricingbarrierFrame) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierFrame::mean(self : FinancepricingbarrierFrame) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierFrame::scale(self : FinancepricingbarrierFrame, f : Double) -> FinancepricingbarrierFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierFrame::add(self : FinancepricingbarrierFrame, other : FinancepricingbarrierFrame) -> FinancepricingbarrierFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierFrame::copy(self : FinancepricingbarrierFrame) -> FinancepricingbarrierFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierFrame::fill(self : FinancepricingbarrierFrame, v : Double) -> FinancepricingbarrierFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierFrame::min(self : FinancepricingbarrierFrame) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierFrame::max(self : FinancepricingbarrierFrame) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierFrame::to_string(self : FinancepricingbarrierFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_table_make(size : Int) -> FinancepricingbarrierTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierTable::len(self : FinancepricingbarrierTable) -> Int { self.size }

pub fn FinancepricingbarrierTable::get(self : FinancepricingbarrierTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierTable::set(self : FinancepricingbarrierTable, i : Int, v : Double) -> FinancepricingbarrierTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierTable::sum(self : FinancepricingbarrierTable) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierTable::mean(self : FinancepricingbarrierTable) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierTable::scale(self : FinancepricingbarrierTable, f : Double) -> FinancepricingbarrierTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierTable::add(self : FinancepricingbarrierTable, other : FinancepricingbarrierTable) -> FinancepricingbarrierTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierTable::copy(self : FinancepricingbarrierTable) -> FinancepricingbarrierTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierTable::fill(self : FinancepricingbarrierTable, v : Double) -> FinancepricingbarrierTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierTable::min(self : FinancepricingbarrierTable) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierTable::max(self : FinancepricingbarrierTable) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierTable::to_string(self : FinancepricingbarrierTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_graphn_make(size : Int) -> FinancepricingbarrierGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierGraphN::len(self : FinancepricingbarrierGraphN) -> Int { self.size }

pub fn FinancepricingbarrierGraphN::get(self : FinancepricingbarrierGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierGraphN::set(self : FinancepricingbarrierGraphN, i : Int, v : Double) -> FinancepricingbarrierGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierGraphN::sum(self : FinancepricingbarrierGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierGraphN::mean(self : FinancepricingbarrierGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierGraphN::scale(self : FinancepricingbarrierGraphN, f : Double) -> FinancepricingbarrierGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierGraphN::add(self : FinancepricingbarrierGraphN, other : FinancepricingbarrierGraphN) -> FinancepricingbarrierGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierGraphN::copy(self : FinancepricingbarrierGraphN) -> FinancepricingbarrierGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierGraphN::fill(self : FinancepricingbarrierGraphN, v : Double) -> FinancepricingbarrierGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierGraphN::min(self : FinancepricingbarrierGraphN) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierGraphN::max(self : FinancepricingbarrierGraphN) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierGraphN::to_string(self : FinancepricingbarrierGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_node_make(size : Int) -> FinancepricingbarrierNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierNode::len(self : FinancepricingbarrierNode) -> Int { self.size }

pub fn FinancepricingbarrierNode::get(self : FinancepricingbarrierNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierNode::set(self : FinancepricingbarrierNode, i : Int, v : Double) -> FinancepricingbarrierNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierNode::sum(self : FinancepricingbarrierNode) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierNode::mean(self : FinancepricingbarrierNode) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierNode::scale(self : FinancepricingbarrierNode, f : Double) -> FinancepricingbarrierNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierNode::add(self : FinancepricingbarrierNode, other : FinancepricingbarrierNode) -> FinancepricingbarrierNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierNode::copy(self : FinancepricingbarrierNode) -> FinancepricingbarrierNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierNode::fill(self : FinancepricingbarrierNode, v : Double) -> FinancepricingbarrierNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierNode::min(self : FinancepricingbarrierNode) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierNode::max(self : FinancepricingbarrierNode) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierNode::to_string(self : FinancepricingbarrierNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_edge_make(size : Int) -> FinancepricingbarrierEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierEdge::len(self : FinancepricingbarrierEdge) -> Int { self.size }

pub fn FinancepricingbarrierEdge::get(self : FinancepricingbarrierEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierEdge::set(self : FinancepricingbarrierEdge, i : Int, v : Double) -> FinancepricingbarrierEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierEdge::sum(self : FinancepricingbarrierEdge) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierEdge::mean(self : FinancepricingbarrierEdge) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierEdge::scale(self : FinancepricingbarrierEdge, f : Double) -> FinancepricingbarrierEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierEdge::add(self : FinancepricingbarrierEdge, other : FinancepricingbarrierEdge) -> FinancepricingbarrierEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierEdge::copy(self : FinancepricingbarrierEdge) -> FinancepricingbarrierEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierEdge::fill(self : FinancepricingbarrierEdge, v : Double) -> FinancepricingbarrierEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierEdge::min(self : FinancepricingbarrierEdge) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierEdge::max(self : FinancepricingbarrierEdge) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierEdge::to_string(self : FinancepricingbarrierEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_path_make(size : Int) -> FinancepricingbarrierPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierPath::len(self : FinancepricingbarrierPath) -> Int { self.size }

pub fn FinancepricingbarrierPath::get(self : FinancepricingbarrierPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierPath::set(self : FinancepricingbarrierPath, i : Int, v : Double) -> FinancepricingbarrierPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierPath::sum(self : FinancepricingbarrierPath) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierPath::mean(self : FinancepricingbarrierPath) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierPath::scale(self : FinancepricingbarrierPath, f : Double) -> FinancepricingbarrierPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierPath::add(self : FinancepricingbarrierPath, other : FinancepricingbarrierPath) -> FinancepricingbarrierPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierPath::copy(self : FinancepricingbarrierPath) -> FinancepricingbarrierPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierPath::fill(self : FinancepricingbarrierPath, v : Double) -> FinancepricingbarrierPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierPath::min(self : FinancepricingbarrierPath) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierPath::max(self : FinancepricingbarrierPath) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierPath::to_string(self : FinancepricingbarrierPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_cluster_make(size : Int) -> FinancepricingbarrierCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierCluster::len(self : FinancepricingbarrierCluster) -> Int { self.size }

pub fn FinancepricingbarrierCluster::get(self : FinancepricingbarrierCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierCluster::set(self : FinancepricingbarrierCluster, i : Int, v : Double) -> FinancepricingbarrierCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierCluster::sum(self : FinancepricingbarrierCluster) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierCluster::mean(self : FinancepricingbarrierCluster) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierCluster::scale(self : FinancepricingbarrierCluster, f : Double) -> FinancepricingbarrierCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierCluster::add(self : FinancepricingbarrierCluster, other : FinancepricingbarrierCluster) -> FinancepricingbarrierCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierCluster::copy(self : FinancepricingbarrierCluster) -> FinancepricingbarrierCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierCluster::fill(self : FinancepricingbarrierCluster, v : Double) -> FinancepricingbarrierCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierCluster::min(self : FinancepricingbarrierCluster) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierCluster::max(self : FinancepricingbarrierCluster) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierCluster::to_string(self : FinancepricingbarrierCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_model_make(size : Int) -> FinancepricingbarrierModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierModel::len(self : FinancepricingbarrierModel) -> Int { self.size }

pub fn FinancepricingbarrierModel::get(self : FinancepricingbarrierModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierModel::set(self : FinancepricingbarrierModel, i : Int, v : Double) -> FinancepricingbarrierModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierModel::sum(self : FinancepricingbarrierModel) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierModel::mean(self : FinancepricingbarrierModel) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierModel::scale(self : FinancepricingbarrierModel, f : Double) -> FinancepricingbarrierModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierModel::add(self : FinancepricingbarrierModel, other : FinancepricingbarrierModel) -> FinancepricingbarrierModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierModel::copy(self : FinancepricingbarrierModel) -> FinancepricingbarrierModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierModel::fill(self : FinancepricingbarrierModel, v : Double) -> FinancepricingbarrierModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierModel::min(self : FinancepricingbarrierModel) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierModel::max(self : FinancepricingbarrierModel) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierModel::to_string(self : FinancepricingbarrierModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_layer_make(size : Int) -> FinancepricingbarrierLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierLayer::len(self : FinancepricingbarrierLayer) -> Int { self.size }

pub fn FinancepricingbarrierLayer::get(self : FinancepricingbarrierLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierLayer::set(self : FinancepricingbarrierLayer, i : Int, v : Double) -> FinancepricingbarrierLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierLayer::sum(self : FinancepricingbarrierLayer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierLayer::mean(self : FinancepricingbarrierLayer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierLayer::scale(self : FinancepricingbarrierLayer, f : Double) -> FinancepricingbarrierLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierLayer::add(self : FinancepricingbarrierLayer, other : FinancepricingbarrierLayer) -> FinancepricingbarrierLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierLayer::copy(self : FinancepricingbarrierLayer) -> FinancepricingbarrierLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierLayer::fill(self : FinancepricingbarrierLayer, v : Double) -> FinancepricingbarrierLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierLayer::min(self : FinancepricingbarrierLayer) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierLayer::max(self : FinancepricingbarrierLayer) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierLayer::to_string(self : FinancepricingbarrierLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_buffer_make(size : Int) -> FinancepricingbarrierBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierBuffer::len(self : FinancepricingbarrierBuffer) -> Int { self.size }

pub fn FinancepricingbarrierBuffer::get(self : FinancepricingbarrierBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierBuffer::set(self : FinancepricingbarrierBuffer, i : Int, v : Double) -> FinancepricingbarrierBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierBuffer::sum(self : FinancepricingbarrierBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierBuffer::mean(self : FinancepricingbarrierBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierBuffer::scale(self : FinancepricingbarrierBuffer, f : Double) -> FinancepricingbarrierBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierBuffer::add(self : FinancepricingbarrierBuffer, other : FinancepricingbarrierBuffer) -> FinancepricingbarrierBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierBuffer::copy(self : FinancepricingbarrierBuffer) -> FinancepricingbarrierBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierBuffer::fill(self : FinancepricingbarrierBuffer, v : Double) -> FinancepricingbarrierBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierBuffer::min(self : FinancepricingbarrierBuffer) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierBuffer::max(self : FinancepricingbarrierBuffer) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierBuffer::to_string(self : FinancepricingbarrierBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_cursor_make(size : Int) -> FinancepricingbarrierCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierCursor::len(self : FinancepricingbarrierCursor) -> Int { self.size }

pub fn FinancepricingbarrierCursor::get(self : FinancepricingbarrierCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierCursor::set(self : FinancepricingbarrierCursor, i : Int, v : Double) -> FinancepricingbarrierCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierCursor::sum(self : FinancepricingbarrierCursor) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierCursor::mean(self : FinancepricingbarrierCursor) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierCursor::scale(self : FinancepricingbarrierCursor, f : Double) -> FinancepricingbarrierCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierCursor::add(self : FinancepricingbarrierCursor, other : FinancepricingbarrierCursor) -> FinancepricingbarrierCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierCursor::copy(self : FinancepricingbarrierCursor) -> FinancepricingbarrierCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierCursor::fill(self : FinancepricingbarrierCursor, v : Double) -> FinancepricingbarrierCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierCursor::min(self : FinancepricingbarrierCursor) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierCursor::max(self : FinancepricingbarrierCursor) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierCursor::to_string(self : FinancepricingbarrierCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_view_make(size : Int) -> FinancepricingbarrierView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierView::len(self : FinancepricingbarrierView) -> Int { self.size }

pub fn FinancepricingbarrierView::get(self : FinancepricingbarrierView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierView::set(self : FinancepricingbarrierView, i : Int, v : Double) -> FinancepricingbarrierView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierView::sum(self : FinancepricingbarrierView) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierView::mean(self : FinancepricingbarrierView) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierView::scale(self : FinancepricingbarrierView, f : Double) -> FinancepricingbarrierView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierView::add(self : FinancepricingbarrierView, other : FinancepricingbarrierView) -> FinancepricingbarrierView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierView::copy(self : FinancepricingbarrierView) -> FinancepricingbarrierView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierView::fill(self : FinancepricingbarrierView, v : Double) -> FinancepricingbarrierView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierView::min(self : FinancepricingbarrierView) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierView::max(self : FinancepricingbarrierView) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierView::to_string(self : FinancepricingbarrierView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_range_make(size : Int) -> FinancepricingbarrierRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierRange::len(self : FinancepricingbarrierRange) -> Int { self.size }

pub fn FinancepricingbarrierRange::get(self : FinancepricingbarrierRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierRange::set(self : FinancepricingbarrierRange, i : Int, v : Double) -> FinancepricingbarrierRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierRange::sum(self : FinancepricingbarrierRange) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierRange::mean(self : FinancepricingbarrierRange) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierRange::scale(self : FinancepricingbarrierRange, f : Double) -> FinancepricingbarrierRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierRange::add(self : FinancepricingbarrierRange, other : FinancepricingbarrierRange) -> FinancepricingbarrierRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierRange::copy(self : FinancepricingbarrierRange) -> FinancepricingbarrierRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierRange::fill(self : FinancepricingbarrierRange, v : Double) -> FinancepricingbarrierRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierRange::min(self : FinancepricingbarrierRange) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierRange::max(self : FinancepricingbarrierRange) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierRange::to_string(self : FinancepricingbarrierRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_slice_make(size : Int) -> FinancepricingbarrierSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbarrierSlice::len(self : FinancepricingbarrierSlice) -> Int { self.size }

pub fn FinancepricingbarrierSlice::get(self : FinancepricingbarrierSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbarrierSlice::set(self : FinancepricingbarrierSlice, i : Int, v : Double) -> FinancepricingbarrierSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierSlice::sum(self : FinancepricingbarrierSlice) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbarrierSlice::mean(self : FinancepricingbarrierSlice) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbarrierSlice::scale(self : FinancepricingbarrierSlice, f : Double) -> FinancepricingbarrierSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierSlice::add(self : FinancepricingbarrierSlice, other : FinancepricingbarrierSlice) -> FinancepricingbarrierSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbarrierSlice::copy(self : FinancepricingbarrierSlice) -> FinancepricingbarrierSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierSlice::fill(self : FinancepricingbarrierSlice, v : Double) -> FinancepricingbarrierSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbarrierSlice::min(self : FinancepricingbarrierSlice) -> Double { @_common.min(self.data) }

pub fn FinancepricingbarrierSlice::max(self : FinancepricingbarrierSlice) -> Double { @_common.max(self.data) }

pub fn FinancepricingbarrierSlice::to_string(self : FinancepricingbarrierSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

