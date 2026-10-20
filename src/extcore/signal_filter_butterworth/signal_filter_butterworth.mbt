///===
/// extcore/signal_filter_butterworth

pub(all) struct SignalfilterbutterworthPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_butterworth_make_point(x : Double, y : Double) -> SignalfilterbutterworthPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_butterworth_make_point3(x : Double, y : Double, z : Double) -> SignalfilterbutterworthPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterbutterworthPoint::x(self : SignalfilterbutterworthPoint) -> Double { self.x }

pub fn SignalfilterbutterworthPoint::y(self : SignalfilterbutterworthPoint) -> Double { self.y }

pub fn SignalfilterbutterworthPoint::z(self : SignalfilterbutterworthPoint) -> Double { self.z }

pub fn SignalfilterbutterworthPoint::label(self : SignalfilterbutterworthPoint) -> Int { self.label }

pub fn SignalfilterbutterworthPoint::dist(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterbutterworthPoint::add(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterbutterworthPoint::sub(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterbutterworthPoint::scale(self : SignalfilterbutterworthPoint, s : Double) -> SignalfilterbutterworthPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterbutterworthPoint::dot(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterbutterworthPoint::cross(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterbutterworthPoint::norm(self : SignalfilterbutterworthPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterbutterworthPoint::normalize(self : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterbutterworthPoint::negate(self : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterbutterworthPoint::mid(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterbutterworthPoint::lerp(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint, t : Double) -> SignalfilterbutterworthPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterbutterworthPoint::to_string(self : SignalfilterbutterworthPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_butterworth_make_series(vals : Array[Double], name : String) -> SignalfilterbutterworthSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterbutterworthSeries::len(self : SignalfilterbutterworthSeries) -> Int { self.vals.length() }

pub fn SignalfilterbutterworthSeries::sum(self : SignalfilterbutterworthSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterbutterworthSeries::mean(self : SignalfilterbutterworthSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterbutterworthSeries::min(self : SignalfilterbutterworthSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterbutterworthSeries::max(self : SignalfilterbutterworthSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterbutterworthSeries::range(self : SignalfilterbutterworthSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterbutterworthSeries::variance(self : SignalfilterbutterworthSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterbutterworthSeries::std(self : SignalfilterbutterworthSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterbutterworthSeries::median(self : SignalfilterbutterworthSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterbutterworthSeries::scale(self : SignalfilterbutterworthSeries, f : Double) -> SignalfilterbutterworthSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterbutterworthSeries::add(self : SignalfilterbutterworthSeries, other : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterbutterworthSeries::sub(self : SignalfilterbutterworthSeries, other : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterbutterworthSeries::normalize(self : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterbutterworthSeries::cumsum(self : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterbutterworthSeries::to_string(self : SignalfilterbutterworthSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterbutterworthMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_butterworth_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterbutterworthMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_filter_butterworth_matrix_identity(n : Int) -> SignalfilterbutterworthMatrix {
  let m = signal_filter_butterworth_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterbutterworthMatrix::get(self : SignalfilterbutterworthMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterbutterworthMatrix::transpose(self : SignalfilterbutterworthMatrix) -> SignalfilterbutterworthMatrix {
  let result = signal_filter_butterworth_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterbutterworthMatrix::add(self : SignalfilterbutterworthMatrix, other : SignalfilterbutterworthMatrix) -> SignalfilterbutterworthMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_butterworth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterbutterworthMatrix::scale(self : SignalfilterbutterworthMatrix, s : Double) -> SignalfilterbutterworthMatrix {
  let result = signal_filter_butterworth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterbutterworthMatrix::multiply(self : SignalfilterbutterworthMatrix, other : SignalfilterbutterworthMatrix) -> SignalfilterbutterworthMatrix {
  if self.cols != other.rows { return signal_filter_butterworth_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_butterworth_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalfilterbutterworthMatrix::trace(self : SignalfilterbutterworthMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterbutterworthMatrix::det(self : SignalfilterbutterworthMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterbutterworthMatrix::norm(self : SignalfilterbutterworthMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterbutterworthMatrix::to_string(self : SignalfilterbutterworthMatrix) -> String {
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

pub(all) struct SignalfilterbutterworthVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_butterworth_make_vector(comps : Array[Double]) -> SignalfilterbutterworthVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_butterworth_vector_zero(dim : Int) -> SignalfilterbutterworthVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterbutterworthVector::add(self : SignalfilterbutterworthVector, other : SignalfilterbutterworthVector) -> SignalfilterbutterworthVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterbutterworthVector::sub(self : SignalfilterbutterworthVector, other : SignalfilterbutterworthVector) -> SignalfilterbutterworthVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterbutterworthVector::scale(self : SignalfilterbutterworthVector, s : Double) -> SignalfilterbutterworthVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterbutterworthVector::dot(self : SignalfilterbutterworthVector, other : SignalfilterbutterworthVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterbutterworthVector::norm(self : SignalfilterbutterworthVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterbutterworthVector::normalize(self : SignalfilterbutterworthVector) -> SignalfilterbutterworthVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterbutterworthVector::dist(self : SignalfilterbutterworthVector, other : SignalfilterbutterworthVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterbutterworthVector::to_string(self : SignalfilterbutterworthVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterbutterworthFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_frame_make(size : Int) -> SignalfilterbutterworthFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthFrame::len(self : SignalfilterbutterworthFrame) -> Int { self.size }

pub fn SignalfilterbutterworthFrame::get(self : SignalfilterbutterworthFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthFrame::set(self : SignalfilterbutterworthFrame, i : Int, v : Double) -> SignalfilterbutterworthFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthFrame::sum(self : SignalfilterbutterworthFrame) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthFrame::mean(self : SignalfilterbutterworthFrame) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthFrame::scale(self : SignalfilterbutterworthFrame, f : Double) -> SignalfilterbutterworthFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthFrame::add(self : SignalfilterbutterworthFrame, other : SignalfilterbutterworthFrame) -> SignalfilterbutterworthFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthFrame::copy(self : SignalfilterbutterworthFrame) -> SignalfilterbutterworthFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthFrame::fill(self : SignalfilterbutterworthFrame, v : Double) -> SignalfilterbutterworthFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthFrame::min(self : SignalfilterbutterworthFrame) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthFrame::max(self : SignalfilterbutterworthFrame) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthFrame::to_string(self : SignalfilterbutterworthFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_table_make(size : Int) -> SignalfilterbutterworthTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthTable::len(self : SignalfilterbutterworthTable) -> Int { self.size }

pub fn SignalfilterbutterworthTable::get(self : SignalfilterbutterworthTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthTable::set(self : SignalfilterbutterworthTable, i : Int, v : Double) -> SignalfilterbutterworthTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthTable::sum(self : SignalfilterbutterworthTable) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthTable::mean(self : SignalfilterbutterworthTable) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthTable::scale(self : SignalfilterbutterworthTable, f : Double) -> SignalfilterbutterworthTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthTable::add(self : SignalfilterbutterworthTable, other : SignalfilterbutterworthTable) -> SignalfilterbutterworthTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthTable::copy(self : SignalfilterbutterworthTable) -> SignalfilterbutterworthTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthTable::fill(self : SignalfilterbutterworthTable, v : Double) -> SignalfilterbutterworthTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthTable::min(self : SignalfilterbutterworthTable) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthTable::max(self : SignalfilterbutterworthTable) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthTable::to_string(self : SignalfilterbutterworthTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_graphn_make(size : Int) -> SignalfilterbutterworthGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthGraphN::len(self : SignalfilterbutterworthGraphN) -> Int { self.size }

pub fn SignalfilterbutterworthGraphN::get(self : SignalfilterbutterworthGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthGraphN::set(self : SignalfilterbutterworthGraphN, i : Int, v : Double) -> SignalfilterbutterworthGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthGraphN::sum(self : SignalfilterbutterworthGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthGraphN::mean(self : SignalfilterbutterworthGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthGraphN::scale(self : SignalfilterbutterworthGraphN, f : Double) -> SignalfilterbutterworthGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthGraphN::add(self : SignalfilterbutterworthGraphN, other : SignalfilterbutterworthGraphN) -> SignalfilterbutterworthGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthGraphN::copy(self : SignalfilterbutterworthGraphN) -> SignalfilterbutterworthGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthGraphN::fill(self : SignalfilterbutterworthGraphN, v : Double) -> SignalfilterbutterworthGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthGraphN::min(self : SignalfilterbutterworthGraphN) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthGraphN::max(self : SignalfilterbutterworthGraphN) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthGraphN::to_string(self : SignalfilterbutterworthGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_node_make(size : Int) -> SignalfilterbutterworthNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthNode::len(self : SignalfilterbutterworthNode) -> Int { self.size }

pub fn SignalfilterbutterworthNode::get(self : SignalfilterbutterworthNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthNode::set(self : SignalfilterbutterworthNode, i : Int, v : Double) -> SignalfilterbutterworthNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthNode::sum(self : SignalfilterbutterworthNode) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthNode::mean(self : SignalfilterbutterworthNode) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthNode::scale(self : SignalfilterbutterworthNode, f : Double) -> SignalfilterbutterworthNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthNode::add(self : SignalfilterbutterworthNode, other : SignalfilterbutterworthNode) -> SignalfilterbutterworthNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthNode::copy(self : SignalfilterbutterworthNode) -> SignalfilterbutterworthNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthNode::fill(self : SignalfilterbutterworthNode, v : Double) -> SignalfilterbutterworthNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthNode::min(self : SignalfilterbutterworthNode) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthNode::max(self : SignalfilterbutterworthNode) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthNode::to_string(self : SignalfilterbutterworthNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_edge_make(size : Int) -> SignalfilterbutterworthEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthEdge::len(self : SignalfilterbutterworthEdge) -> Int { self.size }

pub fn SignalfilterbutterworthEdge::get(self : SignalfilterbutterworthEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthEdge::set(self : SignalfilterbutterworthEdge, i : Int, v : Double) -> SignalfilterbutterworthEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthEdge::sum(self : SignalfilterbutterworthEdge) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthEdge::mean(self : SignalfilterbutterworthEdge) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthEdge::scale(self : SignalfilterbutterworthEdge, f : Double) -> SignalfilterbutterworthEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthEdge::add(self : SignalfilterbutterworthEdge, other : SignalfilterbutterworthEdge) -> SignalfilterbutterworthEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthEdge::copy(self : SignalfilterbutterworthEdge) -> SignalfilterbutterworthEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthEdge::fill(self : SignalfilterbutterworthEdge, v : Double) -> SignalfilterbutterworthEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthEdge::min(self : SignalfilterbutterworthEdge) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthEdge::max(self : SignalfilterbutterworthEdge) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthEdge::to_string(self : SignalfilterbutterworthEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_path_make(size : Int) -> SignalfilterbutterworthPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthPath::len(self : SignalfilterbutterworthPath) -> Int { self.size }

pub fn SignalfilterbutterworthPath::get(self : SignalfilterbutterworthPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthPath::set(self : SignalfilterbutterworthPath, i : Int, v : Double) -> SignalfilterbutterworthPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthPath::sum(self : SignalfilterbutterworthPath) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthPath::mean(self : SignalfilterbutterworthPath) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthPath::scale(self : SignalfilterbutterworthPath, f : Double) -> SignalfilterbutterworthPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthPath::add(self : SignalfilterbutterworthPath, other : SignalfilterbutterworthPath) -> SignalfilterbutterworthPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthPath::copy(self : SignalfilterbutterworthPath) -> SignalfilterbutterworthPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthPath::fill(self : SignalfilterbutterworthPath, v : Double) -> SignalfilterbutterworthPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthPath::min(self : SignalfilterbutterworthPath) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthPath::max(self : SignalfilterbutterworthPath) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthPath::to_string(self : SignalfilterbutterworthPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_cluster_make(size : Int) -> SignalfilterbutterworthCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthCluster::len(self : SignalfilterbutterworthCluster) -> Int { self.size }

pub fn SignalfilterbutterworthCluster::get(self : SignalfilterbutterworthCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthCluster::set(self : SignalfilterbutterworthCluster, i : Int, v : Double) -> SignalfilterbutterworthCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthCluster::sum(self : SignalfilterbutterworthCluster) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthCluster::mean(self : SignalfilterbutterworthCluster) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthCluster::scale(self : SignalfilterbutterworthCluster, f : Double) -> SignalfilterbutterworthCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthCluster::add(self : SignalfilterbutterworthCluster, other : SignalfilterbutterworthCluster) -> SignalfilterbutterworthCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthCluster::copy(self : SignalfilterbutterworthCluster) -> SignalfilterbutterworthCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthCluster::fill(self : SignalfilterbutterworthCluster, v : Double) -> SignalfilterbutterworthCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthCluster::min(self : SignalfilterbutterworthCluster) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthCluster::max(self : SignalfilterbutterworthCluster) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthCluster::to_string(self : SignalfilterbutterworthCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_model_make(size : Int) -> SignalfilterbutterworthModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthModel::len(self : SignalfilterbutterworthModel) -> Int { self.size }

pub fn SignalfilterbutterworthModel::get(self : SignalfilterbutterworthModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthModel::set(self : SignalfilterbutterworthModel, i : Int, v : Double) -> SignalfilterbutterworthModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthModel::sum(self : SignalfilterbutterworthModel) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthModel::mean(self : SignalfilterbutterworthModel) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthModel::scale(self : SignalfilterbutterworthModel, f : Double) -> SignalfilterbutterworthModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthModel::add(self : SignalfilterbutterworthModel, other : SignalfilterbutterworthModel) -> SignalfilterbutterworthModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthModel::copy(self : SignalfilterbutterworthModel) -> SignalfilterbutterworthModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthModel::fill(self : SignalfilterbutterworthModel, v : Double) -> SignalfilterbutterworthModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthModel::min(self : SignalfilterbutterworthModel) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthModel::max(self : SignalfilterbutterworthModel) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthModel::to_string(self : SignalfilterbutterworthModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_layer_make(size : Int) -> SignalfilterbutterworthLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthLayer::len(self : SignalfilterbutterworthLayer) -> Int { self.size }

pub fn SignalfilterbutterworthLayer::get(self : SignalfilterbutterworthLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthLayer::set(self : SignalfilterbutterworthLayer, i : Int, v : Double) -> SignalfilterbutterworthLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthLayer::sum(self : SignalfilterbutterworthLayer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthLayer::mean(self : SignalfilterbutterworthLayer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthLayer::scale(self : SignalfilterbutterworthLayer, f : Double) -> SignalfilterbutterworthLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthLayer::add(self : SignalfilterbutterworthLayer, other : SignalfilterbutterworthLayer) -> SignalfilterbutterworthLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthLayer::copy(self : SignalfilterbutterworthLayer) -> SignalfilterbutterworthLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthLayer::fill(self : SignalfilterbutterworthLayer, v : Double) -> SignalfilterbutterworthLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthLayer::min(self : SignalfilterbutterworthLayer) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthLayer::max(self : SignalfilterbutterworthLayer) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthLayer::to_string(self : SignalfilterbutterworthLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_buffer_make(size : Int) -> SignalfilterbutterworthBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthBuffer::len(self : SignalfilterbutterworthBuffer) -> Int { self.size }

pub fn SignalfilterbutterworthBuffer::get(self : SignalfilterbutterworthBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthBuffer::set(self : SignalfilterbutterworthBuffer, i : Int, v : Double) -> SignalfilterbutterworthBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthBuffer::sum(self : SignalfilterbutterworthBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthBuffer::mean(self : SignalfilterbutterworthBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthBuffer::scale(self : SignalfilterbutterworthBuffer, f : Double) -> SignalfilterbutterworthBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthBuffer::add(self : SignalfilterbutterworthBuffer, other : SignalfilterbutterworthBuffer) -> SignalfilterbutterworthBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthBuffer::copy(self : SignalfilterbutterworthBuffer) -> SignalfilterbutterworthBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthBuffer::fill(self : SignalfilterbutterworthBuffer, v : Double) -> SignalfilterbutterworthBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthBuffer::min(self : SignalfilterbutterworthBuffer) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthBuffer::max(self : SignalfilterbutterworthBuffer) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthBuffer::to_string(self : SignalfilterbutterworthBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_cursor_make(size : Int) -> SignalfilterbutterworthCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthCursor::len(self : SignalfilterbutterworthCursor) -> Int { self.size }

pub fn SignalfilterbutterworthCursor::get(self : SignalfilterbutterworthCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthCursor::set(self : SignalfilterbutterworthCursor, i : Int, v : Double) -> SignalfilterbutterworthCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthCursor::sum(self : SignalfilterbutterworthCursor) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthCursor::mean(self : SignalfilterbutterworthCursor) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthCursor::scale(self : SignalfilterbutterworthCursor, f : Double) -> SignalfilterbutterworthCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthCursor::add(self : SignalfilterbutterworthCursor, other : SignalfilterbutterworthCursor) -> SignalfilterbutterworthCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthCursor::copy(self : SignalfilterbutterworthCursor) -> SignalfilterbutterworthCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthCursor::fill(self : SignalfilterbutterworthCursor, v : Double) -> SignalfilterbutterworthCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthCursor::min(self : SignalfilterbutterworthCursor) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthCursor::max(self : SignalfilterbutterworthCursor) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthCursor::to_string(self : SignalfilterbutterworthCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_view_make(size : Int) -> SignalfilterbutterworthView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthView::len(self : SignalfilterbutterworthView) -> Int { self.size }

pub fn SignalfilterbutterworthView::get(self : SignalfilterbutterworthView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthView::set(self : SignalfilterbutterworthView, i : Int, v : Double) -> SignalfilterbutterworthView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthView::sum(self : SignalfilterbutterworthView) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthView::mean(self : SignalfilterbutterworthView) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthView::scale(self : SignalfilterbutterworthView, f : Double) -> SignalfilterbutterworthView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthView::add(self : SignalfilterbutterworthView, other : SignalfilterbutterworthView) -> SignalfilterbutterworthView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthView::copy(self : SignalfilterbutterworthView) -> SignalfilterbutterworthView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthView::fill(self : SignalfilterbutterworthView, v : Double) -> SignalfilterbutterworthView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthView::min(self : SignalfilterbutterworthView) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthView::max(self : SignalfilterbutterworthView) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthView::to_string(self : SignalfilterbutterworthView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_range_make(size : Int) -> SignalfilterbutterworthRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthRange::len(self : SignalfilterbutterworthRange) -> Int { self.size }

pub fn SignalfilterbutterworthRange::get(self : SignalfilterbutterworthRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthRange::set(self : SignalfilterbutterworthRange, i : Int, v : Double) -> SignalfilterbutterworthRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthRange::sum(self : SignalfilterbutterworthRange) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthRange::mean(self : SignalfilterbutterworthRange) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthRange::scale(self : SignalfilterbutterworthRange, f : Double) -> SignalfilterbutterworthRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthRange::add(self : SignalfilterbutterworthRange, other : SignalfilterbutterworthRange) -> SignalfilterbutterworthRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthRange::copy(self : SignalfilterbutterworthRange) -> SignalfilterbutterworthRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthRange::fill(self : SignalfilterbutterworthRange, v : Double) -> SignalfilterbutterworthRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthRange::min(self : SignalfilterbutterworthRange) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthRange::max(self : SignalfilterbutterworthRange) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthRange::to_string(self : SignalfilterbutterworthRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_slice_make(size : Int) -> SignalfilterbutterworthSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbutterworthSlice::len(self : SignalfilterbutterworthSlice) -> Int { self.size }

pub fn SignalfilterbutterworthSlice::get(self : SignalfilterbutterworthSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbutterworthSlice::set(self : SignalfilterbutterworthSlice, i : Int, v : Double) -> SignalfilterbutterworthSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthSlice::sum(self : SignalfilterbutterworthSlice) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbutterworthSlice::mean(self : SignalfilterbutterworthSlice) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbutterworthSlice::scale(self : SignalfilterbutterworthSlice, f : Double) -> SignalfilterbutterworthSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthSlice::add(self : SignalfilterbutterworthSlice, other : SignalfilterbutterworthSlice) -> SignalfilterbutterworthSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbutterworthSlice::copy(self : SignalfilterbutterworthSlice) -> SignalfilterbutterworthSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthSlice::fill(self : SignalfilterbutterworthSlice, v : Double) -> SignalfilterbutterworthSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbutterworthSlice::min(self : SignalfilterbutterworthSlice) -> Double { @_common.min(self.data) }

pub fn SignalfilterbutterworthSlice::max(self : SignalfilterbutterworthSlice) -> Double { @_common.max(self.data) }

pub fn SignalfilterbutterworthSlice::to_string(self : SignalfilterbutterworthSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

