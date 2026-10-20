///===
/// extcore/signal_filter_fir

pub(all) struct SignalfilterfirPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_fir_make_point(x : Double, y : Double) -> SignalfilterfirPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_fir_make_point3(x : Double, y : Double, z : Double) -> SignalfilterfirPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterfirPoint::x(self : SignalfilterfirPoint) -> Double { self.x }

pub fn SignalfilterfirPoint::y(self : SignalfilterfirPoint) -> Double { self.y }

pub fn SignalfilterfirPoint::z(self : SignalfilterfirPoint) -> Double { self.z }

pub fn SignalfilterfirPoint::label(self : SignalfilterfirPoint) -> Int { self.label }

pub fn SignalfilterfirPoint::dist(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterfirPoint::add(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterfirPoint::sub(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterfirPoint::scale(self : SignalfilterfirPoint, s : Double) -> SignalfilterfirPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterfirPoint::dot(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterfirPoint::cross(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterfirPoint::norm(self : SignalfilterfirPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterfirPoint::normalize(self : SignalfilterfirPoint) -> SignalfilterfirPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterfirPoint::negate(self : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterfirPoint::mid(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterfirPoint::lerp(self : SignalfilterfirPoint, other : SignalfilterfirPoint, t : Double) -> SignalfilterfirPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterfirPoint::to_string(self : SignalfilterfirPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterfirSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_fir_make_series(vals : Array[Double], name : String) -> SignalfilterfirSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterfirSeries::len(self : SignalfilterfirSeries) -> Int { self.vals.length() }

pub fn SignalfilterfirSeries::sum(self : SignalfilterfirSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterfirSeries::mean(self : SignalfilterfirSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterfirSeries::min(self : SignalfilterfirSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterfirSeries::max(self : SignalfilterfirSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterfirSeries::range(self : SignalfilterfirSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterfirSeries::variance(self : SignalfilterfirSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterfirSeries::std(self : SignalfilterfirSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterfirSeries::median(self : SignalfilterfirSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterfirSeries::scale(self : SignalfilterfirSeries, f : Double) -> SignalfilterfirSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterfirSeries::add(self : SignalfilterfirSeries, other : SignalfilterfirSeries) -> SignalfilterfirSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterfirSeries::sub(self : SignalfilterfirSeries, other : SignalfilterfirSeries) -> SignalfilterfirSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterfirSeries::normalize(self : SignalfilterfirSeries) -> SignalfilterfirSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterfirSeries::cumsum(self : SignalfilterfirSeries) -> SignalfilterfirSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterfirSeries::to_string(self : SignalfilterfirSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterfirMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_fir_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterfirMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_fir_matrix_identity(n : Int) -> SignalfilterfirMatrix {
  let m = signal_filter_fir_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterfirMatrix::get(self : SignalfilterfirMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterfirMatrix::transpose(self : SignalfilterfirMatrix) -> SignalfilterfirMatrix {
  let result = signal_filter_fir_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterfirMatrix::add(self : SignalfilterfirMatrix, other : SignalfilterfirMatrix) -> SignalfilterfirMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_fir_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterfirMatrix::scale(self : SignalfilterfirMatrix, s : Double) -> SignalfilterfirMatrix {
  let result = signal_filter_fir_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterfirMatrix::multiply(self : SignalfilterfirMatrix, other : SignalfilterfirMatrix) -> SignalfilterfirMatrix {
  if self.cols != other.rows { return signal_filter_fir_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_fir_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalfilterfirMatrix::trace(self : SignalfilterfirMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterfirMatrix::det(self : SignalfilterfirMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterfirMatrix::norm(self : SignalfilterfirMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterfirMatrix::to_string(self : SignalfilterfirMatrix) -> String {
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

pub(all) struct SignalfilterfirVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_fir_make_vector(comps : Array[Double]) -> SignalfilterfirVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_fir_vector_zero(dim : Int) -> SignalfilterfirVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterfirVector::add(self : SignalfilterfirVector, other : SignalfilterfirVector) -> SignalfilterfirVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterfirVector::sub(self : SignalfilterfirVector, other : SignalfilterfirVector) -> SignalfilterfirVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterfirVector::scale(self : SignalfilterfirVector, s : Double) -> SignalfilterfirVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterfirVector::dot(self : SignalfilterfirVector, other : SignalfilterfirVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterfirVector::norm(self : SignalfilterfirVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterfirVector::normalize(self : SignalfilterfirVector) -> SignalfilterfirVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterfirVector::dist(self : SignalfilterfirVector, other : SignalfilterfirVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterfirVector::to_string(self : SignalfilterfirVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterfirFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_frame_make(size : Int) -> SignalfilterfirFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirFrame::len(self : SignalfilterfirFrame) -> Int { self.size }

pub fn SignalfilterfirFrame::get(self : SignalfilterfirFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirFrame::set(self : SignalfilterfirFrame, i : Int, v : Double) -> SignalfilterfirFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirFrame::sum(self : SignalfilterfirFrame) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirFrame::mean(self : SignalfilterfirFrame) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirFrame::scale(self : SignalfilterfirFrame, f : Double) -> SignalfilterfirFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirFrame::add(self : SignalfilterfirFrame, other : SignalfilterfirFrame) -> SignalfilterfirFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirFrame::copy(self : SignalfilterfirFrame) -> SignalfilterfirFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirFrame::fill(self : SignalfilterfirFrame, v : Double) -> SignalfilterfirFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirFrame::min(self : SignalfilterfirFrame) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirFrame::max(self : SignalfilterfirFrame) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirFrame::to_string(self : SignalfilterfirFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_table_make(size : Int) -> SignalfilterfirTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirTable::len(self : SignalfilterfirTable) -> Int { self.size }

pub fn SignalfilterfirTable::get(self : SignalfilterfirTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirTable::set(self : SignalfilterfirTable, i : Int, v : Double) -> SignalfilterfirTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirTable::sum(self : SignalfilterfirTable) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirTable::mean(self : SignalfilterfirTable) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirTable::scale(self : SignalfilterfirTable, f : Double) -> SignalfilterfirTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirTable::add(self : SignalfilterfirTable, other : SignalfilterfirTable) -> SignalfilterfirTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirTable::copy(self : SignalfilterfirTable) -> SignalfilterfirTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirTable::fill(self : SignalfilterfirTable, v : Double) -> SignalfilterfirTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirTable::min(self : SignalfilterfirTable) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirTable::max(self : SignalfilterfirTable) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirTable::to_string(self : SignalfilterfirTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_graphn_make(size : Int) -> SignalfilterfirGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirGraphN::len(self : SignalfilterfirGraphN) -> Int { self.size }

pub fn SignalfilterfirGraphN::get(self : SignalfilterfirGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirGraphN::set(self : SignalfilterfirGraphN, i : Int, v : Double) -> SignalfilterfirGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirGraphN::sum(self : SignalfilterfirGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirGraphN::mean(self : SignalfilterfirGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirGraphN::scale(self : SignalfilterfirGraphN, f : Double) -> SignalfilterfirGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirGraphN::add(self : SignalfilterfirGraphN, other : SignalfilterfirGraphN) -> SignalfilterfirGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirGraphN::copy(self : SignalfilterfirGraphN) -> SignalfilterfirGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirGraphN::fill(self : SignalfilterfirGraphN, v : Double) -> SignalfilterfirGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirGraphN::min(self : SignalfilterfirGraphN) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirGraphN::max(self : SignalfilterfirGraphN) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirGraphN::to_string(self : SignalfilterfirGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_node_make(size : Int) -> SignalfilterfirNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirNode::len(self : SignalfilterfirNode) -> Int { self.size }

pub fn SignalfilterfirNode::get(self : SignalfilterfirNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirNode::set(self : SignalfilterfirNode, i : Int, v : Double) -> SignalfilterfirNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirNode::sum(self : SignalfilterfirNode) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirNode::mean(self : SignalfilterfirNode) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirNode::scale(self : SignalfilterfirNode, f : Double) -> SignalfilterfirNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirNode::add(self : SignalfilterfirNode, other : SignalfilterfirNode) -> SignalfilterfirNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirNode::copy(self : SignalfilterfirNode) -> SignalfilterfirNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirNode::fill(self : SignalfilterfirNode, v : Double) -> SignalfilterfirNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirNode::min(self : SignalfilterfirNode) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirNode::max(self : SignalfilterfirNode) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirNode::to_string(self : SignalfilterfirNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_edge_make(size : Int) -> SignalfilterfirEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirEdge::len(self : SignalfilterfirEdge) -> Int { self.size }

pub fn SignalfilterfirEdge::get(self : SignalfilterfirEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirEdge::set(self : SignalfilterfirEdge, i : Int, v : Double) -> SignalfilterfirEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirEdge::sum(self : SignalfilterfirEdge) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirEdge::mean(self : SignalfilterfirEdge) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirEdge::scale(self : SignalfilterfirEdge, f : Double) -> SignalfilterfirEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirEdge::add(self : SignalfilterfirEdge, other : SignalfilterfirEdge) -> SignalfilterfirEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirEdge::copy(self : SignalfilterfirEdge) -> SignalfilterfirEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirEdge::fill(self : SignalfilterfirEdge, v : Double) -> SignalfilterfirEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirEdge::min(self : SignalfilterfirEdge) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirEdge::max(self : SignalfilterfirEdge) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirEdge::to_string(self : SignalfilterfirEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_path_make(size : Int) -> SignalfilterfirPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirPath::len(self : SignalfilterfirPath) -> Int { self.size }

pub fn SignalfilterfirPath::get(self : SignalfilterfirPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirPath::set(self : SignalfilterfirPath, i : Int, v : Double) -> SignalfilterfirPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirPath::sum(self : SignalfilterfirPath) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirPath::mean(self : SignalfilterfirPath) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirPath::scale(self : SignalfilterfirPath, f : Double) -> SignalfilterfirPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirPath::add(self : SignalfilterfirPath, other : SignalfilterfirPath) -> SignalfilterfirPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirPath::copy(self : SignalfilterfirPath) -> SignalfilterfirPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirPath::fill(self : SignalfilterfirPath, v : Double) -> SignalfilterfirPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirPath::min(self : SignalfilterfirPath) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirPath::max(self : SignalfilterfirPath) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirPath::to_string(self : SignalfilterfirPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_cluster_make(size : Int) -> SignalfilterfirCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirCluster::len(self : SignalfilterfirCluster) -> Int { self.size }

pub fn SignalfilterfirCluster::get(self : SignalfilterfirCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirCluster::set(self : SignalfilterfirCluster, i : Int, v : Double) -> SignalfilterfirCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirCluster::sum(self : SignalfilterfirCluster) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirCluster::mean(self : SignalfilterfirCluster) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirCluster::scale(self : SignalfilterfirCluster, f : Double) -> SignalfilterfirCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirCluster::add(self : SignalfilterfirCluster, other : SignalfilterfirCluster) -> SignalfilterfirCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirCluster::copy(self : SignalfilterfirCluster) -> SignalfilterfirCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirCluster::fill(self : SignalfilterfirCluster, v : Double) -> SignalfilterfirCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirCluster::min(self : SignalfilterfirCluster) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirCluster::max(self : SignalfilterfirCluster) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirCluster::to_string(self : SignalfilterfirCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_model_make(size : Int) -> SignalfilterfirModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirModel::len(self : SignalfilterfirModel) -> Int { self.size }

pub fn SignalfilterfirModel::get(self : SignalfilterfirModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirModel::set(self : SignalfilterfirModel, i : Int, v : Double) -> SignalfilterfirModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirModel::sum(self : SignalfilterfirModel) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirModel::mean(self : SignalfilterfirModel) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirModel::scale(self : SignalfilterfirModel, f : Double) -> SignalfilterfirModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirModel::add(self : SignalfilterfirModel, other : SignalfilterfirModel) -> SignalfilterfirModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirModel::copy(self : SignalfilterfirModel) -> SignalfilterfirModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirModel::fill(self : SignalfilterfirModel, v : Double) -> SignalfilterfirModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirModel::min(self : SignalfilterfirModel) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirModel::max(self : SignalfilterfirModel) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirModel::to_string(self : SignalfilterfirModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_layer_make(size : Int) -> SignalfilterfirLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirLayer::len(self : SignalfilterfirLayer) -> Int { self.size }

pub fn SignalfilterfirLayer::get(self : SignalfilterfirLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirLayer::set(self : SignalfilterfirLayer, i : Int, v : Double) -> SignalfilterfirLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirLayer::sum(self : SignalfilterfirLayer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirLayer::mean(self : SignalfilterfirLayer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirLayer::scale(self : SignalfilterfirLayer, f : Double) -> SignalfilterfirLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirLayer::add(self : SignalfilterfirLayer, other : SignalfilterfirLayer) -> SignalfilterfirLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirLayer::copy(self : SignalfilterfirLayer) -> SignalfilterfirLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirLayer::fill(self : SignalfilterfirLayer, v : Double) -> SignalfilterfirLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirLayer::min(self : SignalfilterfirLayer) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirLayer::max(self : SignalfilterfirLayer) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirLayer::to_string(self : SignalfilterfirLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_buffer_make(size : Int) -> SignalfilterfirBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirBuffer::len(self : SignalfilterfirBuffer) -> Int { self.size }

pub fn SignalfilterfirBuffer::get(self : SignalfilterfirBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirBuffer::set(self : SignalfilterfirBuffer, i : Int, v : Double) -> SignalfilterfirBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirBuffer::sum(self : SignalfilterfirBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirBuffer::mean(self : SignalfilterfirBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirBuffer::scale(self : SignalfilterfirBuffer, f : Double) -> SignalfilterfirBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirBuffer::add(self : SignalfilterfirBuffer, other : SignalfilterfirBuffer) -> SignalfilterfirBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirBuffer::copy(self : SignalfilterfirBuffer) -> SignalfilterfirBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirBuffer::fill(self : SignalfilterfirBuffer, v : Double) -> SignalfilterfirBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirBuffer::min(self : SignalfilterfirBuffer) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirBuffer::max(self : SignalfilterfirBuffer) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirBuffer::to_string(self : SignalfilterfirBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_cursor_make(size : Int) -> SignalfilterfirCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirCursor::len(self : SignalfilterfirCursor) -> Int { self.size }

pub fn SignalfilterfirCursor::get(self : SignalfilterfirCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirCursor::set(self : SignalfilterfirCursor, i : Int, v : Double) -> SignalfilterfirCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirCursor::sum(self : SignalfilterfirCursor) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirCursor::mean(self : SignalfilterfirCursor) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirCursor::scale(self : SignalfilterfirCursor, f : Double) -> SignalfilterfirCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirCursor::add(self : SignalfilterfirCursor, other : SignalfilterfirCursor) -> SignalfilterfirCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirCursor::copy(self : SignalfilterfirCursor) -> SignalfilterfirCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirCursor::fill(self : SignalfilterfirCursor, v : Double) -> SignalfilterfirCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirCursor::min(self : SignalfilterfirCursor) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirCursor::max(self : SignalfilterfirCursor) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirCursor::to_string(self : SignalfilterfirCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_view_make(size : Int) -> SignalfilterfirView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirView::len(self : SignalfilterfirView) -> Int { self.size }

pub fn SignalfilterfirView::get(self : SignalfilterfirView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirView::set(self : SignalfilterfirView, i : Int, v : Double) -> SignalfilterfirView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirView::sum(self : SignalfilterfirView) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirView::mean(self : SignalfilterfirView) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirView::scale(self : SignalfilterfirView, f : Double) -> SignalfilterfirView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirView::add(self : SignalfilterfirView, other : SignalfilterfirView) -> SignalfilterfirView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirView::copy(self : SignalfilterfirView) -> SignalfilterfirView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirView::fill(self : SignalfilterfirView, v : Double) -> SignalfilterfirView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirView::min(self : SignalfilterfirView) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirView::max(self : SignalfilterfirView) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirView::to_string(self : SignalfilterfirView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_range_make(size : Int) -> SignalfilterfirRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirRange::len(self : SignalfilterfirRange) -> Int { self.size }

pub fn SignalfilterfirRange::get(self : SignalfilterfirRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirRange::set(self : SignalfilterfirRange, i : Int, v : Double) -> SignalfilterfirRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirRange::sum(self : SignalfilterfirRange) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirRange::mean(self : SignalfilterfirRange) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirRange::scale(self : SignalfilterfirRange, f : Double) -> SignalfilterfirRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirRange::add(self : SignalfilterfirRange, other : SignalfilterfirRange) -> SignalfilterfirRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirRange::copy(self : SignalfilterfirRange) -> SignalfilterfirRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirRange::fill(self : SignalfilterfirRange, v : Double) -> SignalfilterfirRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirRange::min(self : SignalfilterfirRange) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirRange::max(self : SignalfilterfirRange) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirRange::to_string(self : SignalfilterfirRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_slice_make(size : Int) -> SignalfilterfirSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterfirSlice::len(self : SignalfilterfirSlice) -> Int { self.size }

pub fn SignalfilterfirSlice::get(self : SignalfilterfirSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterfirSlice::set(self : SignalfilterfirSlice, i : Int, v : Double) -> SignalfilterfirSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterfirSlice::sum(self : SignalfilterfirSlice) -> Double { @_common.sum(self.data) }

pub fn SignalfilterfirSlice::mean(self : SignalfilterfirSlice) -> Double { @_common.mean(self.data) }

pub fn SignalfilterfirSlice::scale(self : SignalfilterfirSlice, f : Double) -> SignalfilterfirSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirSlice::add(self : SignalfilterfirSlice, other : SignalfilterfirSlice) -> SignalfilterfirSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterfirSlice::copy(self : SignalfilterfirSlice) -> SignalfilterfirSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirSlice::fill(self : SignalfilterfirSlice, v : Double) -> SignalfilterfirSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterfirSlice::min(self : SignalfilterfirSlice) -> Double { @_common.min(self.data) }

pub fn SignalfilterfirSlice::max(self : SignalfilterfirSlice) -> Double { @_common.max(self.data) }

pub fn SignalfilterfirSlice::to_string(self : SignalfilterfirSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

