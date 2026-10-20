///===
/// extcore/signal_filter_bessel

pub(all) struct SignalfilterbesselPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_bessel_make_point(x : Double, y : Double) -> SignalfilterbesselPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_bessel_make_point3(x : Double, y : Double, z : Double) -> SignalfilterbesselPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterbesselPoint::x(self : SignalfilterbesselPoint) -> Double { self.x }

pub fn SignalfilterbesselPoint::y(self : SignalfilterbesselPoint) -> Double { self.y }

pub fn SignalfilterbesselPoint::z(self : SignalfilterbesselPoint) -> Double { self.z }

pub fn SignalfilterbesselPoint::label(self : SignalfilterbesselPoint) -> Int { self.label }

pub fn SignalfilterbesselPoint::dist(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterbesselPoint::add(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterbesselPoint::sub(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterbesselPoint::scale(self : SignalfilterbesselPoint, s : Double) -> SignalfilterbesselPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterbesselPoint::dot(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterbesselPoint::cross(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterbesselPoint::norm(self : SignalfilterbesselPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterbesselPoint::normalize(self : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterbesselPoint::negate(self : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterbesselPoint::mid(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterbesselPoint::lerp(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint, t : Double) -> SignalfilterbesselPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterbesselPoint::to_string(self : SignalfilterbesselPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterbesselSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_bessel_make_series(vals : Array[Double], name : String) -> SignalfilterbesselSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterbesselSeries::len(self : SignalfilterbesselSeries) -> Int { self.vals.length() }

pub fn SignalfilterbesselSeries::sum(self : SignalfilterbesselSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterbesselSeries::mean(self : SignalfilterbesselSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterbesselSeries::min(self : SignalfilterbesselSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterbesselSeries::max(self : SignalfilterbesselSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterbesselSeries::range(self : SignalfilterbesselSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterbesselSeries::variance(self : SignalfilterbesselSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterbesselSeries::std(self : SignalfilterbesselSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterbesselSeries::median(self : SignalfilterbesselSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterbesselSeries::scale(self : SignalfilterbesselSeries, f : Double) -> SignalfilterbesselSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterbesselSeries::add(self : SignalfilterbesselSeries, other : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterbesselSeries::sub(self : SignalfilterbesselSeries, other : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterbesselSeries::normalize(self : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterbesselSeries::cumsum(self : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterbesselSeries::to_string(self : SignalfilterbesselSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterbesselMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_bessel_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterbesselMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_filter_bessel_matrix_identity(n : Int) -> SignalfilterbesselMatrix {
  let m = signal_filter_bessel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterbesselMatrix::get(self : SignalfilterbesselMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterbesselMatrix::transpose(self : SignalfilterbesselMatrix) -> SignalfilterbesselMatrix {
  let result = signal_filter_bessel_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterbesselMatrix::add(self : SignalfilterbesselMatrix, other : SignalfilterbesselMatrix) -> SignalfilterbesselMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_bessel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterbesselMatrix::scale(self : SignalfilterbesselMatrix, s : Double) -> SignalfilterbesselMatrix {
  let result = signal_filter_bessel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterbesselMatrix::multiply(self : SignalfilterbesselMatrix, other : SignalfilterbesselMatrix) -> SignalfilterbesselMatrix {
  if self.cols != other.rows { return signal_filter_bessel_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_bessel_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalfilterbesselMatrix::trace(self : SignalfilterbesselMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterbesselMatrix::det(self : SignalfilterbesselMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterbesselMatrix::norm(self : SignalfilterbesselMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterbesselMatrix::to_string(self : SignalfilterbesselMatrix) -> String {
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

pub(all) struct SignalfilterbesselVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_bessel_make_vector(comps : Array[Double]) -> SignalfilterbesselVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_bessel_vector_zero(dim : Int) -> SignalfilterbesselVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterbesselVector::add(self : SignalfilterbesselVector, other : SignalfilterbesselVector) -> SignalfilterbesselVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterbesselVector::sub(self : SignalfilterbesselVector, other : SignalfilterbesselVector) -> SignalfilterbesselVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterbesselVector::scale(self : SignalfilterbesselVector, s : Double) -> SignalfilterbesselVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterbesselVector::dot(self : SignalfilterbesselVector, other : SignalfilterbesselVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterbesselVector::norm(self : SignalfilterbesselVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterbesselVector::normalize(self : SignalfilterbesselVector) -> SignalfilterbesselVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterbesselVector::dist(self : SignalfilterbesselVector, other : SignalfilterbesselVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterbesselVector::to_string(self : SignalfilterbesselVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterbesselFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_frame_make(size : Int) -> SignalfilterbesselFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselFrame::len(self : SignalfilterbesselFrame) -> Int { self.size }

pub fn SignalfilterbesselFrame::get(self : SignalfilterbesselFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselFrame::set(self : SignalfilterbesselFrame, i : Int, v : Double) -> SignalfilterbesselFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselFrame::sum(self : SignalfilterbesselFrame) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselFrame::mean(self : SignalfilterbesselFrame) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselFrame::scale(self : SignalfilterbesselFrame, f : Double) -> SignalfilterbesselFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselFrame::add(self : SignalfilterbesselFrame, other : SignalfilterbesselFrame) -> SignalfilterbesselFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselFrame::copy(self : SignalfilterbesselFrame) -> SignalfilterbesselFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselFrame::fill(self : SignalfilterbesselFrame, v : Double) -> SignalfilterbesselFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselFrame::min(self : SignalfilterbesselFrame) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselFrame::max(self : SignalfilterbesselFrame) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselFrame::to_string(self : SignalfilterbesselFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_table_make(size : Int) -> SignalfilterbesselTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselTable::len(self : SignalfilterbesselTable) -> Int { self.size }

pub fn SignalfilterbesselTable::get(self : SignalfilterbesselTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselTable::set(self : SignalfilterbesselTable, i : Int, v : Double) -> SignalfilterbesselTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselTable::sum(self : SignalfilterbesselTable) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselTable::mean(self : SignalfilterbesselTable) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselTable::scale(self : SignalfilterbesselTable, f : Double) -> SignalfilterbesselTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselTable::add(self : SignalfilterbesselTable, other : SignalfilterbesselTable) -> SignalfilterbesselTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselTable::copy(self : SignalfilterbesselTable) -> SignalfilterbesselTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselTable::fill(self : SignalfilterbesselTable, v : Double) -> SignalfilterbesselTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselTable::min(self : SignalfilterbesselTable) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselTable::max(self : SignalfilterbesselTable) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselTable::to_string(self : SignalfilterbesselTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_graphn_make(size : Int) -> SignalfilterbesselGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselGraphN::len(self : SignalfilterbesselGraphN) -> Int { self.size }

pub fn SignalfilterbesselGraphN::get(self : SignalfilterbesselGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselGraphN::set(self : SignalfilterbesselGraphN, i : Int, v : Double) -> SignalfilterbesselGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselGraphN::sum(self : SignalfilterbesselGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselGraphN::mean(self : SignalfilterbesselGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselGraphN::scale(self : SignalfilterbesselGraphN, f : Double) -> SignalfilterbesselGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselGraphN::add(self : SignalfilterbesselGraphN, other : SignalfilterbesselGraphN) -> SignalfilterbesselGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselGraphN::copy(self : SignalfilterbesselGraphN) -> SignalfilterbesselGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselGraphN::fill(self : SignalfilterbesselGraphN, v : Double) -> SignalfilterbesselGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselGraphN::min(self : SignalfilterbesselGraphN) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselGraphN::max(self : SignalfilterbesselGraphN) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselGraphN::to_string(self : SignalfilterbesselGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_node_make(size : Int) -> SignalfilterbesselNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselNode::len(self : SignalfilterbesselNode) -> Int { self.size }

pub fn SignalfilterbesselNode::get(self : SignalfilterbesselNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselNode::set(self : SignalfilterbesselNode, i : Int, v : Double) -> SignalfilterbesselNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselNode::sum(self : SignalfilterbesselNode) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselNode::mean(self : SignalfilterbesselNode) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselNode::scale(self : SignalfilterbesselNode, f : Double) -> SignalfilterbesselNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselNode::add(self : SignalfilterbesselNode, other : SignalfilterbesselNode) -> SignalfilterbesselNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselNode::copy(self : SignalfilterbesselNode) -> SignalfilterbesselNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselNode::fill(self : SignalfilterbesselNode, v : Double) -> SignalfilterbesselNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselNode::min(self : SignalfilterbesselNode) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselNode::max(self : SignalfilterbesselNode) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselNode::to_string(self : SignalfilterbesselNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_edge_make(size : Int) -> SignalfilterbesselEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselEdge::len(self : SignalfilterbesselEdge) -> Int { self.size }

pub fn SignalfilterbesselEdge::get(self : SignalfilterbesselEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselEdge::set(self : SignalfilterbesselEdge, i : Int, v : Double) -> SignalfilterbesselEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselEdge::sum(self : SignalfilterbesselEdge) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselEdge::mean(self : SignalfilterbesselEdge) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselEdge::scale(self : SignalfilterbesselEdge, f : Double) -> SignalfilterbesselEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselEdge::add(self : SignalfilterbesselEdge, other : SignalfilterbesselEdge) -> SignalfilterbesselEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselEdge::copy(self : SignalfilterbesselEdge) -> SignalfilterbesselEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselEdge::fill(self : SignalfilterbesselEdge, v : Double) -> SignalfilterbesselEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselEdge::min(self : SignalfilterbesselEdge) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselEdge::max(self : SignalfilterbesselEdge) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselEdge::to_string(self : SignalfilterbesselEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_path_make(size : Int) -> SignalfilterbesselPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselPath::len(self : SignalfilterbesselPath) -> Int { self.size }

pub fn SignalfilterbesselPath::get(self : SignalfilterbesselPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselPath::set(self : SignalfilterbesselPath, i : Int, v : Double) -> SignalfilterbesselPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselPath::sum(self : SignalfilterbesselPath) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselPath::mean(self : SignalfilterbesselPath) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselPath::scale(self : SignalfilterbesselPath, f : Double) -> SignalfilterbesselPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselPath::add(self : SignalfilterbesselPath, other : SignalfilterbesselPath) -> SignalfilterbesselPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselPath::copy(self : SignalfilterbesselPath) -> SignalfilterbesselPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselPath::fill(self : SignalfilterbesselPath, v : Double) -> SignalfilterbesselPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselPath::min(self : SignalfilterbesselPath) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselPath::max(self : SignalfilterbesselPath) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselPath::to_string(self : SignalfilterbesselPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_cluster_make(size : Int) -> SignalfilterbesselCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselCluster::len(self : SignalfilterbesselCluster) -> Int { self.size }

pub fn SignalfilterbesselCluster::get(self : SignalfilterbesselCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselCluster::set(self : SignalfilterbesselCluster, i : Int, v : Double) -> SignalfilterbesselCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselCluster::sum(self : SignalfilterbesselCluster) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselCluster::mean(self : SignalfilterbesselCluster) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselCluster::scale(self : SignalfilterbesselCluster, f : Double) -> SignalfilterbesselCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselCluster::add(self : SignalfilterbesselCluster, other : SignalfilterbesselCluster) -> SignalfilterbesselCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselCluster::copy(self : SignalfilterbesselCluster) -> SignalfilterbesselCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselCluster::fill(self : SignalfilterbesselCluster, v : Double) -> SignalfilterbesselCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselCluster::min(self : SignalfilterbesselCluster) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselCluster::max(self : SignalfilterbesselCluster) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselCluster::to_string(self : SignalfilterbesselCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_model_make(size : Int) -> SignalfilterbesselModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselModel::len(self : SignalfilterbesselModel) -> Int { self.size }

pub fn SignalfilterbesselModel::get(self : SignalfilterbesselModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselModel::set(self : SignalfilterbesselModel, i : Int, v : Double) -> SignalfilterbesselModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselModel::sum(self : SignalfilterbesselModel) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselModel::mean(self : SignalfilterbesselModel) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselModel::scale(self : SignalfilterbesselModel, f : Double) -> SignalfilterbesselModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselModel::add(self : SignalfilterbesselModel, other : SignalfilterbesselModel) -> SignalfilterbesselModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselModel::copy(self : SignalfilterbesselModel) -> SignalfilterbesselModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselModel::fill(self : SignalfilterbesselModel, v : Double) -> SignalfilterbesselModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselModel::min(self : SignalfilterbesselModel) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselModel::max(self : SignalfilterbesselModel) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselModel::to_string(self : SignalfilterbesselModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_layer_make(size : Int) -> SignalfilterbesselLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselLayer::len(self : SignalfilterbesselLayer) -> Int { self.size }

pub fn SignalfilterbesselLayer::get(self : SignalfilterbesselLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselLayer::set(self : SignalfilterbesselLayer, i : Int, v : Double) -> SignalfilterbesselLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselLayer::sum(self : SignalfilterbesselLayer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselLayer::mean(self : SignalfilterbesselLayer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselLayer::scale(self : SignalfilterbesselLayer, f : Double) -> SignalfilterbesselLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselLayer::add(self : SignalfilterbesselLayer, other : SignalfilterbesselLayer) -> SignalfilterbesselLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselLayer::copy(self : SignalfilterbesselLayer) -> SignalfilterbesselLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselLayer::fill(self : SignalfilterbesselLayer, v : Double) -> SignalfilterbesselLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselLayer::min(self : SignalfilterbesselLayer) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselLayer::max(self : SignalfilterbesselLayer) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselLayer::to_string(self : SignalfilterbesselLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_buffer_make(size : Int) -> SignalfilterbesselBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselBuffer::len(self : SignalfilterbesselBuffer) -> Int { self.size }

pub fn SignalfilterbesselBuffer::get(self : SignalfilterbesselBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselBuffer::set(self : SignalfilterbesselBuffer, i : Int, v : Double) -> SignalfilterbesselBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselBuffer::sum(self : SignalfilterbesselBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselBuffer::mean(self : SignalfilterbesselBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselBuffer::scale(self : SignalfilterbesselBuffer, f : Double) -> SignalfilterbesselBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselBuffer::add(self : SignalfilterbesselBuffer, other : SignalfilterbesselBuffer) -> SignalfilterbesselBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselBuffer::copy(self : SignalfilterbesselBuffer) -> SignalfilterbesselBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselBuffer::fill(self : SignalfilterbesselBuffer, v : Double) -> SignalfilterbesselBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselBuffer::min(self : SignalfilterbesselBuffer) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselBuffer::max(self : SignalfilterbesselBuffer) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselBuffer::to_string(self : SignalfilterbesselBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_cursor_make(size : Int) -> SignalfilterbesselCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselCursor::len(self : SignalfilterbesselCursor) -> Int { self.size }

pub fn SignalfilterbesselCursor::get(self : SignalfilterbesselCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselCursor::set(self : SignalfilterbesselCursor, i : Int, v : Double) -> SignalfilterbesselCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselCursor::sum(self : SignalfilterbesselCursor) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselCursor::mean(self : SignalfilterbesselCursor) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselCursor::scale(self : SignalfilterbesselCursor, f : Double) -> SignalfilterbesselCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselCursor::add(self : SignalfilterbesselCursor, other : SignalfilterbesselCursor) -> SignalfilterbesselCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselCursor::copy(self : SignalfilterbesselCursor) -> SignalfilterbesselCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselCursor::fill(self : SignalfilterbesselCursor, v : Double) -> SignalfilterbesselCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselCursor::min(self : SignalfilterbesselCursor) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselCursor::max(self : SignalfilterbesselCursor) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselCursor::to_string(self : SignalfilterbesselCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_view_make(size : Int) -> SignalfilterbesselView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselView::len(self : SignalfilterbesselView) -> Int { self.size }

pub fn SignalfilterbesselView::get(self : SignalfilterbesselView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselView::set(self : SignalfilterbesselView, i : Int, v : Double) -> SignalfilterbesselView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselView::sum(self : SignalfilterbesselView) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselView::mean(self : SignalfilterbesselView) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselView::scale(self : SignalfilterbesselView, f : Double) -> SignalfilterbesselView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselView::add(self : SignalfilterbesselView, other : SignalfilterbesselView) -> SignalfilterbesselView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselView::copy(self : SignalfilterbesselView) -> SignalfilterbesselView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselView::fill(self : SignalfilterbesselView, v : Double) -> SignalfilterbesselView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselView::min(self : SignalfilterbesselView) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselView::max(self : SignalfilterbesselView) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselView::to_string(self : SignalfilterbesselView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_range_make(size : Int) -> SignalfilterbesselRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselRange::len(self : SignalfilterbesselRange) -> Int { self.size }

pub fn SignalfilterbesselRange::get(self : SignalfilterbesselRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselRange::set(self : SignalfilterbesselRange, i : Int, v : Double) -> SignalfilterbesselRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselRange::sum(self : SignalfilterbesselRange) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselRange::mean(self : SignalfilterbesselRange) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselRange::scale(self : SignalfilterbesselRange, f : Double) -> SignalfilterbesselRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselRange::add(self : SignalfilterbesselRange, other : SignalfilterbesselRange) -> SignalfilterbesselRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselRange::copy(self : SignalfilterbesselRange) -> SignalfilterbesselRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselRange::fill(self : SignalfilterbesselRange, v : Double) -> SignalfilterbesselRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselRange::min(self : SignalfilterbesselRange) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselRange::max(self : SignalfilterbesselRange) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselRange::to_string(self : SignalfilterbesselRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_slice_make(size : Int) -> SignalfilterbesselSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterbesselSlice::len(self : SignalfilterbesselSlice) -> Int { self.size }

pub fn SignalfilterbesselSlice::get(self : SignalfilterbesselSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterbesselSlice::set(self : SignalfilterbesselSlice, i : Int, v : Double) -> SignalfilterbesselSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselSlice::sum(self : SignalfilterbesselSlice) -> Double { @_common.sum(self.data) }

pub fn SignalfilterbesselSlice::mean(self : SignalfilterbesselSlice) -> Double { @_common.mean(self.data) }

pub fn SignalfilterbesselSlice::scale(self : SignalfilterbesselSlice, f : Double) -> SignalfilterbesselSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselSlice::add(self : SignalfilterbesselSlice, other : SignalfilterbesselSlice) -> SignalfilterbesselSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterbesselSlice::copy(self : SignalfilterbesselSlice) -> SignalfilterbesselSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselSlice::fill(self : SignalfilterbesselSlice, v : Double) -> SignalfilterbesselSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterbesselSlice::min(self : SignalfilterbesselSlice) -> Double { @_common.min(self.data) }

pub fn SignalfilterbesselSlice::max(self : SignalfilterbesselSlice) -> Double { @_common.max(self.data) }

pub fn SignalfilterbesselSlice::to_string(self : SignalfilterbesselSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

