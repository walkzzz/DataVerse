///===
/// extcore/sort_exchange_odd_even

pub(all) struct SortexchangeoddevenPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_odd_even_make_point(x : Double, y : Double) -> SortexchangeoddevenPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_odd_even_make_point3(x : Double, y : Double, z : Double) -> SortexchangeoddevenPoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangeoddevenPoint::x(self : SortexchangeoddevenPoint) -> Double { self.x }

pub fn SortexchangeoddevenPoint::y(self : SortexchangeoddevenPoint) -> Double { self.y }

pub fn SortexchangeoddevenPoint::z(self : SortexchangeoddevenPoint) -> Double { self.z }

pub fn SortexchangeoddevenPoint::label(self : SortexchangeoddevenPoint) -> Int { self.label }

pub fn SortexchangeoddevenPoint::dist(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangeoddevenPoint::add(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangeoddevenPoint::sub(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangeoddevenPoint::scale(self : SortexchangeoddevenPoint, s : Double) -> SortexchangeoddevenPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangeoddevenPoint::dot(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangeoddevenPoint::cross(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangeoddevenPoint::norm(self : SortexchangeoddevenPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangeoddevenPoint::normalize(self : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangeoddevenPoint::negate(self : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangeoddevenPoint::mid(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangeoddevenPoint::lerp(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint, t : Double) -> SortexchangeoddevenPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangeoddevenPoint::to_string(self : SortexchangeoddevenPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangeoddevenSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_odd_even_make_series(vals : Array[Double], name : String) -> SortexchangeoddevenSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangeoddevenSeries::len(self : SortexchangeoddevenSeries) -> Int { self.vals.length() }

pub fn SortexchangeoddevenSeries::sum(self : SortexchangeoddevenSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangeoddevenSeries::mean(self : SortexchangeoddevenSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangeoddevenSeries::min(self : SortexchangeoddevenSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangeoddevenSeries::max(self : SortexchangeoddevenSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangeoddevenSeries::range(self : SortexchangeoddevenSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangeoddevenSeries::variance(self : SortexchangeoddevenSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangeoddevenSeries::std(self : SortexchangeoddevenSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangeoddevenSeries::median(self : SortexchangeoddevenSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangeoddevenSeries::scale(self : SortexchangeoddevenSeries, f : Double) -> SortexchangeoddevenSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangeoddevenSeries::add(self : SortexchangeoddevenSeries, other : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangeoddevenSeries::sub(self : SortexchangeoddevenSeries, other : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangeoddevenSeries::normalize(self : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangeoddevenSeries::cumsum(self : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangeoddevenSeries::to_string(self : SortexchangeoddevenSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangeoddevenMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_odd_even_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangeoddevenMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_odd_even_matrix_identity(n : Int) -> SortexchangeoddevenMatrix {
  let m = sort_exchange_odd_even_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangeoddevenMatrix::get(self : SortexchangeoddevenMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangeoddevenMatrix::transpose(self : SortexchangeoddevenMatrix) -> SortexchangeoddevenMatrix {
  let result = sort_exchange_odd_even_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangeoddevenMatrix::add(self : SortexchangeoddevenMatrix, other : SortexchangeoddevenMatrix) -> SortexchangeoddevenMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_odd_even_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangeoddevenMatrix::scale(self : SortexchangeoddevenMatrix, s : Double) -> SortexchangeoddevenMatrix {
  let result = sort_exchange_odd_even_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangeoddevenMatrix::multiply(self : SortexchangeoddevenMatrix, other : SortexchangeoddevenMatrix) -> SortexchangeoddevenMatrix {
  if self.cols != other.rows { return sort_exchange_odd_even_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_odd_even_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangeoddevenMatrix::trace(self : SortexchangeoddevenMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangeoddevenMatrix::det(self : SortexchangeoddevenMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangeoddevenMatrix::norm(self : SortexchangeoddevenMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangeoddevenMatrix::to_string(self : SortexchangeoddevenMatrix) -> String {
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

pub(all) struct SortexchangeoddevenVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_odd_even_make_vector(comps : Array[Double]) -> SortexchangeoddevenVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_odd_even_vector_zero(dim : Int) -> SortexchangeoddevenVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangeoddevenVector::add(self : SortexchangeoddevenVector, other : SortexchangeoddevenVector) -> SortexchangeoddevenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangeoddevenVector::sub(self : SortexchangeoddevenVector, other : SortexchangeoddevenVector) -> SortexchangeoddevenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangeoddevenVector::scale(self : SortexchangeoddevenVector, s : Double) -> SortexchangeoddevenVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangeoddevenVector::dot(self : SortexchangeoddevenVector, other : SortexchangeoddevenVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangeoddevenVector::norm(self : SortexchangeoddevenVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangeoddevenVector::normalize(self : SortexchangeoddevenVector) -> SortexchangeoddevenVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangeoddevenVector::dist(self : SortexchangeoddevenVector, other : SortexchangeoddevenVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangeoddevenVector::to_string(self : SortexchangeoddevenVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangeoddevenFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_frame_make(size : Int) -> SortexchangeoddevenFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenFrame::len(self : SortexchangeoddevenFrame) -> Int { self.size }

pub fn SortexchangeoddevenFrame::get(self : SortexchangeoddevenFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenFrame::set(self : SortexchangeoddevenFrame, i : Int, v : Double) -> SortexchangeoddevenFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenFrame::sum(self : SortexchangeoddevenFrame) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenFrame::mean(self : SortexchangeoddevenFrame) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenFrame::scale(self : SortexchangeoddevenFrame, f : Double) -> SortexchangeoddevenFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenFrame::add(self : SortexchangeoddevenFrame, other : SortexchangeoddevenFrame) -> SortexchangeoddevenFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenFrame::copy(self : SortexchangeoddevenFrame) -> SortexchangeoddevenFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenFrame::fill(self : SortexchangeoddevenFrame, v : Double) -> SortexchangeoddevenFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenFrame::min(self : SortexchangeoddevenFrame) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenFrame::max(self : SortexchangeoddevenFrame) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenFrame::to_string(self : SortexchangeoddevenFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_table_make(size : Int) -> SortexchangeoddevenTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenTable::len(self : SortexchangeoddevenTable) -> Int { self.size }

pub fn SortexchangeoddevenTable::get(self : SortexchangeoddevenTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenTable::set(self : SortexchangeoddevenTable, i : Int, v : Double) -> SortexchangeoddevenTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenTable::sum(self : SortexchangeoddevenTable) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenTable::mean(self : SortexchangeoddevenTable) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenTable::scale(self : SortexchangeoddevenTable, f : Double) -> SortexchangeoddevenTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenTable::add(self : SortexchangeoddevenTable, other : SortexchangeoddevenTable) -> SortexchangeoddevenTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenTable::copy(self : SortexchangeoddevenTable) -> SortexchangeoddevenTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenTable::fill(self : SortexchangeoddevenTable, v : Double) -> SortexchangeoddevenTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenTable::min(self : SortexchangeoddevenTable) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenTable::max(self : SortexchangeoddevenTable) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenTable::to_string(self : SortexchangeoddevenTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_graphn_make(size : Int) -> SortexchangeoddevenGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenGraphN::len(self : SortexchangeoddevenGraphN) -> Int { self.size }

pub fn SortexchangeoddevenGraphN::get(self : SortexchangeoddevenGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenGraphN::set(self : SortexchangeoddevenGraphN, i : Int, v : Double) -> SortexchangeoddevenGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenGraphN::sum(self : SortexchangeoddevenGraphN) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenGraphN::mean(self : SortexchangeoddevenGraphN) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenGraphN::scale(self : SortexchangeoddevenGraphN, f : Double) -> SortexchangeoddevenGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenGraphN::add(self : SortexchangeoddevenGraphN, other : SortexchangeoddevenGraphN) -> SortexchangeoddevenGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenGraphN::copy(self : SortexchangeoddevenGraphN) -> SortexchangeoddevenGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenGraphN::fill(self : SortexchangeoddevenGraphN, v : Double) -> SortexchangeoddevenGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenGraphN::min(self : SortexchangeoddevenGraphN) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenGraphN::max(self : SortexchangeoddevenGraphN) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenGraphN::to_string(self : SortexchangeoddevenGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_node_make(size : Int) -> SortexchangeoddevenNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenNode::len(self : SortexchangeoddevenNode) -> Int { self.size }

pub fn SortexchangeoddevenNode::get(self : SortexchangeoddevenNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenNode::set(self : SortexchangeoddevenNode, i : Int, v : Double) -> SortexchangeoddevenNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenNode::sum(self : SortexchangeoddevenNode) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenNode::mean(self : SortexchangeoddevenNode) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenNode::scale(self : SortexchangeoddevenNode, f : Double) -> SortexchangeoddevenNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenNode::add(self : SortexchangeoddevenNode, other : SortexchangeoddevenNode) -> SortexchangeoddevenNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenNode::copy(self : SortexchangeoddevenNode) -> SortexchangeoddevenNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenNode::fill(self : SortexchangeoddevenNode, v : Double) -> SortexchangeoddevenNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenNode::min(self : SortexchangeoddevenNode) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenNode::max(self : SortexchangeoddevenNode) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenNode::to_string(self : SortexchangeoddevenNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_edge_make(size : Int) -> SortexchangeoddevenEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenEdge::len(self : SortexchangeoddevenEdge) -> Int { self.size }

pub fn SortexchangeoddevenEdge::get(self : SortexchangeoddevenEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenEdge::set(self : SortexchangeoddevenEdge, i : Int, v : Double) -> SortexchangeoddevenEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenEdge::sum(self : SortexchangeoddevenEdge) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenEdge::mean(self : SortexchangeoddevenEdge) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenEdge::scale(self : SortexchangeoddevenEdge, f : Double) -> SortexchangeoddevenEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenEdge::add(self : SortexchangeoddevenEdge, other : SortexchangeoddevenEdge) -> SortexchangeoddevenEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenEdge::copy(self : SortexchangeoddevenEdge) -> SortexchangeoddevenEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenEdge::fill(self : SortexchangeoddevenEdge, v : Double) -> SortexchangeoddevenEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenEdge::min(self : SortexchangeoddevenEdge) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenEdge::max(self : SortexchangeoddevenEdge) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenEdge::to_string(self : SortexchangeoddevenEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_path_make(size : Int) -> SortexchangeoddevenPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenPath::len(self : SortexchangeoddevenPath) -> Int { self.size }

pub fn SortexchangeoddevenPath::get(self : SortexchangeoddevenPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenPath::set(self : SortexchangeoddevenPath, i : Int, v : Double) -> SortexchangeoddevenPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenPath::sum(self : SortexchangeoddevenPath) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenPath::mean(self : SortexchangeoddevenPath) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenPath::scale(self : SortexchangeoddevenPath, f : Double) -> SortexchangeoddevenPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenPath::add(self : SortexchangeoddevenPath, other : SortexchangeoddevenPath) -> SortexchangeoddevenPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenPath::copy(self : SortexchangeoddevenPath) -> SortexchangeoddevenPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenPath::fill(self : SortexchangeoddevenPath, v : Double) -> SortexchangeoddevenPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenPath::min(self : SortexchangeoddevenPath) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenPath::max(self : SortexchangeoddevenPath) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenPath::to_string(self : SortexchangeoddevenPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_cluster_make(size : Int) -> SortexchangeoddevenCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenCluster::len(self : SortexchangeoddevenCluster) -> Int { self.size }

pub fn SortexchangeoddevenCluster::get(self : SortexchangeoddevenCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenCluster::set(self : SortexchangeoddevenCluster, i : Int, v : Double) -> SortexchangeoddevenCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenCluster::sum(self : SortexchangeoddevenCluster) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenCluster::mean(self : SortexchangeoddevenCluster) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenCluster::scale(self : SortexchangeoddevenCluster, f : Double) -> SortexchangeoddevenCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenCluster::add(self : SortexchangeoddevenCluster, other : SortexchangeoddevenCluster) -> SortexchangeoddevenCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenCluster::copy(self : SortexchangeoddevenCluster) -> SortexchangeoddevenCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenCluster::fill(self : SortexchangeoddevenCluster, v : Double) -> SortexchangeoddevenCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenCluster::min(self : SortexchangeoddevenCluster) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenCluster::max(self : SortexchangeoddevenCluster) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenCluster::to_string(self : SortexchangeoddevenCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_model_make(size : Int) -> SortexchangeoddevenModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenModel::len(self : SortexchangeoddevenModel) -> Int { self.size }

pub fn SortexchangeoddevenModel::get(self : SortexchangeoddevenModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenModel::set(self : SortexchangeoddevenModel, i : Int, v : Double) -> SortexchangeoddevenModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenModel::sum(self : SortexchangeoddevenModel) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenModel::mean(self : SortexchangeoddevenModel) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenModel::scale(self : SortexchangeoddevenModel, f : Double) -> SortexchangeoddevenModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenModel::add(self : SortexchangeoddevenModel, other : SortexchangeoddevenModel) -> SortexchangeoddevenModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenModel::copy(self : SortexchangeoddevenModel) -> SortexchangeoddevenModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenModel::fill(self : SortexchangeoddevenModel, v : Double) -> SortexchangeoddevenModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenModel::min(self : SortexchangeoddevenModel) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenModel::max(self : SortexchangeoddevenModel) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenModel::to_string(self : SortexchangeoddevenModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_layer_make(size : Int) -> SortexchangeoddevenLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenLayer::len(self : SortexchangeoddevenLayer) -> Int { self.size }

pub fn SortexchangeoddevenLayer::get(self : SortexchangeoddevenLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenLayer::set(self : SortexchangeoddevenLayer, i : Int, v : Double) -> SortexchangeoddevenLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenLayer::sum(self : SortexchangeoddevenLayer) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenLayer::mean(self : SortexchangeoddevenLayer) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenLayer::scale(self : SortexchangeoddevenLayer, f : Double) -> SortexchangeoddevenLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenLayer::add(self : SortexchangeoddevenLayer, other : SortexchangeoddevenLayer) -> SortexchangeoddevenLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenLayer::copy(self : SortexchangeoddevenLayer) -> SortexchangeoddevenLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenLayer::fill(self : SortexchangeoddevenLayer, v : Double) -> SortexchangeoddevenLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenLayer::min(self : SortexchangeoddevenLayer) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenLayer::max(self : SortexchangeoddevenLayer) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenLayer::to_string(self : SortexchangeoddevenLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_buffer_make(size : Int) -> SortexchangeoddevenBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenBuffer::len(self : SortexchangeoddevenBuffer) -> Int { self.size }

pub fn SortexchangeoddevenBuffer::get(self : SortexchangeoddevenBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenBuffer::set(self : SortexchangeoddevenBuffer, i : Int, v : Double) -> SortexchangeoddevenBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenBuffer::sum(self : SortexchangeoddevenBuffer) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenBuffer::mean(self : SortexchangeoddevenBuffer) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenBuffer::scale(self : SortexchangeoddevenBuffer, f : Double) -> SortexchangeoddevenBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenBuffer::add(self : SortexchangeoddevenBuffer, other : SortexchangeoddevenBuffer) -> SortexchangeoddevenBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenBuffer::copy(self : SortexchangeoddevenBuffer) -> SortexchangeoddevenBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenBuffer::fill(self : SortexchangeoddevenBuffer, v : Double) -> SortexchangeoddevenBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenBuffer::min(self : SortexchangeoddevenBuffer) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenBuffer::max(self : SortexchangeoddevenBuffer) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenBuffer::to_string(self : SortexchangeoddevenBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_cursor_make(size : Int) -> SortexchangeoddevenCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenCursor::len(self : SortexchangeoddevenCursor) -> Int { self.size }

pub fn SortexchangeoddevenCursor::get(self : SortexchangeoddevenCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenCursor::set(self : SortexchangeoddevenCursor, i : Int, v : Double) -> SortexchangeoddevenCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenCursor::sum(self : SortexchangeoddevenCursor) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenCursor::mean(self : SortexchangeoddevenCursor) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenCursor::scale(self : SortexchangeoddevenCursor, f : Double) -> SortexchangeoddevenCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenCursor::add(self : SortexchangeoddevenCursor, other : SortexchangeoddevenCursor) -> SortexchangeoddevenCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenCursor::copy(self : SortexchangeoddevenCursor) -> SortexchangeoddevenCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenCursor::fill(self : SortexchangeoddevenCursor, v : Double) -> SortexchangeoddevenCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenCursor::min(self : SortexchangeoddevenCursor) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenCursor::max(self : SortexchangeoddevenCursor) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenCursor::to_string(self : SortexchangeoddevenCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_view_make(size : Int) -> SortexchangeoddevenView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenView::len(self : SortexchangeoddevenView) -> Int { self.size }

pub fn SortexchangeoddevenView::get(self : SortexchangeoddevenView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenView::set(self : SortexchangeoddevenView, i : Int, v : Double) -> SortexchangeoddevenView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenView::sum(self : SortexchangeoddevenView) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenView::mean(self : SortexchangeoddevenView) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenView::scale(self : SortexchangeoddevenView, f : Double) -> SortexchangeoddevenView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenView::add(self : SortexchangeoddevenView, other : SortexchangeoddevenView) -> SortexchangeoddevenView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenView::copy(self : SortexchangeoddevenView) -> SortexchangeoddevenView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenView::fill(self : SortexchangeoddevenView, v : Double) -> SortexchangeoddevenView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenView::min(self : SortexchangeoddevenView) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenView::max(self : SortexchangeoddevenView) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenView::to_string(self : SortexchangeoddevenView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_range_make(size : Int) -> SortexchangeoddevenRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenRange::len(self : SortexchangeoddevenRange) -> Int { self.size }

pub fn SortexchangeoddevenRange::get(self : SortexchangeoddevenRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenRange::set(self : SortexchangeoddevenRange, i : Int, v : Double) -> SortexchangeoddevenRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenRange::sum(self : SortexchangeoddevenRange) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenRange::mean(self : SortexchangeoddevenRange) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenRange::scale(self : SortexchangeoddevenRange, f : Double) -> SortexchangeoddevenRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenRange::add(self : SortexchangeoddevenRange, other : SortexchangeoddevenRange) -> SortexchangeoddevenRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenRange::copy(self : SortexchangeoddevenRange) -> SortexchangeoddevenRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenRange::fill(self : SortexchangeoddevenRange, v : Double) -> SortexchangeoddevenRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenRange::min(self : SortexchangeoddevenRange) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenRange::max(self : SortexchangeoddevenRange) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenRange::to_string(self : SortexchangeoddevenRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_slice_make(size : Int) -> SortexchangeoddevenSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangeoddevenSlice::len(self : SortexchangeoddevenSlice) -> Int { self.size }

pub fn SortexchangeoddevenSlice::get(self : SortexchangeoddevenSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangeoddevenSlice::set(self : SortexchangeoddevenSlice, i : Int, v : Double) -> SortexchangeoddevenSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenSlice::sum(self : SortexchangeoddevenSlice) -> Double { @_common.sum(self.data) }

pub fn SortexchangeoddevenSlice::mean(self : SortexchangeoddevenSlice) -> Double { @_common.mean(self.data) }

pub fn SortexchangeoddevenSlice::scale(self : SortexchangeoddevenSlice, f : Double) -> SortexchangeoddevenSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenSlice::add(self : SortexchangeoddevenSlice, other : SortexchangeoddevenSlice) -> SortexchangeoddevenSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangeoddevenSlice::copy(self : SortexchangeoddevenSlice) -> SortexchangeoddevenSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenSlice::fill(self : SortexchangeoddevenSlice, v : Double) -> SortexchangeoddevenSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangeoddevenSlice::min(self : SortexchangeoddevenSlice) -> Double { @_common.min(self.data) }

pub fn SortexchangeoddevenSlice::max(self : SortexchangeoddevenSlice) -> Double { @_common.max(self.data) }

pub fn SortexchangeoddevenSlice::to_string(self : SortexchangeoddevenSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

