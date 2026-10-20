///===
/// extcore/signal_transform_hilbert

pub(all) struct SignaltransformhilbertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_hilbert_make_point(x : Double, y : Double) -> SignaltransformhilbertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_hilbert_make_point3(x : Double, y : Double, z : Double) -> SignaltransformhilbertPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformhilbertPoint::x(self : SignaltransformhilbertPoint) -> Double { self.x }

pub fn SignaltransformhilbertPoint::y(self : SignaltransformhilbertPoint) -> Double { self.y }

pub fn SignaltransformhilbertPoint::z(self : SignaltransformhilbertPoint) -> Double { self.z }

pub fn SignaltransformhilbertPoint::label(self : SignaltransformhilbertPoint) -> Int { self.label }

pub fn SignaltransformhilbertPoint::dist(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformhilbertPoint::add(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformhilbertPoint::sub(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformhilbertPoint::scale(self : SignaltransformhilbertPoint, s : Double) -> SignaltransformhilbertPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformhilbertPoint::dot(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformhilbertPoint::cross(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformhilbertPoint::norm(self : SignaltransformhilbertPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformhilbertPoint::normalize(self : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformhilbertPoint::negate(self : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformhilbertPoint::mid(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformhilbertPoint::lerp(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint, t : Double) -> SignaltransformhilbertPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformhilbertPoint::to_string(self : SignaltransformhilbertPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformhilbertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_hilbert_make_series(vals : Array[Double], name : String) -> SignaltransformhilbertSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformhilbertSeries::len(self : SignaltransformhilbertSeries) -> Int { self.vals.length() }

pub fn SignaltransformhilbertSeries::sum(self : SignaltransformhilbertSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformhilbertSeries::mean(self : SignaltransformhilbertSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformhilbertSeries::min(self : SignaltransformhilbertSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformhilbertSeries::max(self : SignaltransformhilbertSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformhilbertSeries::range(self : SignaltransformhilbertSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformhilbertSeries::variance(self : SignaltransformhilbertSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformhilbertSeries::std(self : SignaltransformhilbertSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformhilbertSeries::median(self : SignaltransformhilbertSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformhilbertSeries::scale(self : SignaltransformhilbertSeries, f : Double) -> SignaltransformhilbertSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformhilbertSeries::add(self : SignaltransformhilbertSeries, other : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformhilbertSeries::sub(self : SignaltransformhilbertSeries, other : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformhilbertSeries::normalize(self : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformhilbertSeries::cumsum(self : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformhilbertSeries::to_string(self : SignaltransformhilbertSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformhilbertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_hilbert_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformhilbertMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_hilbert_matrix_identity(n : Int) -> SignaltransformhilbertMatrix {
  let m = signal_transform_hilbert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformhilbertMatrix::get(self : SignaltransformhilbertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformhilbertMatrix::transpose(self : SignaltransformhilbertMatrix) -> SignaltransformhilbertMatrix {
  let result = signal_transform_hilbert_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformhilbertMatrix::add(self : SignaltransformhilbertMatrix, other : SignaltransformhilbertMatrix) -> SignaltransformhilbertMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_hilbert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformhilbertMatrix::scale(self : SignaltransformhilbertMatrix, s : Double) -> SignaltransformhilbertMatrix {
  let result = signal_transform_hilbert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformhilbertMatrix::multiply(self : SignaltransformhilbertMatrix, other : SignaltransformhilbertMatrix) -> SignaltransformhilbertMatrix {
  if self.cols != other.rows { return signal_transform_hilbert_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_hilbert_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformhilbertMatrix::trace(self : SignaltransformhilbertMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformhilbertMatrix::det(self : SignaltransformhilbertMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformhilbertMatrix::norm(self : SignaltransformhilbertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformhilbertMatrix::to_string(self : SignaltransformhilbertMatrix) -> String {
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

pub(all) struct SignaltransformhilbertVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_hilbert_make_vector(comps : Array[Double]) -> SignaltransformhilbertVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_hilbert_vector_zero(dim : Int) -> SignaltransformhilbertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformhilbertVector::add(self : SignaltransformhilbertVector, other : SignaltransformhilbertVector) -> SignaltransformhilbertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformhilbertVector::sub(self : SignaltransformhilbertVector, other : SignaltransformhilbertVector) -> SignaltransformhilbertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformhilbertVector::scale(self : SignaltransformhilbertVector, s : Double) -> SignaltransformhilbertVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformhilbertVector::dot(self : SignaltransformhilbertVector, other : SignaltransformhilbertVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformhilbertVector::norm(self : SignaltransformhilbertVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformhilbertVector::normalize(self : SignaltransformhilbertVector) -> SignaltransformhilbertVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformhilbertVector::dist(self : SignaltransformhilbertVector, other : SignaltransformhilbertVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformhilbertVector::to_string(self : SignaltransformhilbertVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformhilbertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_frame_make(size : Int) -> SignaltransformhilbertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertFrame::len(self : SignaltransformhilbertFrame) -> Int { self.size }

pub fn SignaltransformhilbertFrame::get(self : SignaltransformhilbertFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertFrame::set(self : SignaltransformhilbertFrame, i : Int, v : Double) -> SignaltransformhilbertFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertFrame::sum(self : SignaltransformhilbertFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertFrame::mean(self : SignaltransformhilbertFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertFrame::scale(self : SignaltransformhilbertFrame, f : Double) -> SignaltransformhilbertFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertFrame::add(self : SignaltransformhilbertFrame, other : SignaltransformhilbertFrame) -> SignaltransformhilbertFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertFrame::copy(self : SignaltransformhilbertFrame) -> SignaltransformhilbertFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertFrame::fill(self : SignaltransformhilbertFrame, v : Double) -> SignaltransformhilbertFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertFrame::min(self : SignaltransformhilbertFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertFrame::max(self : SignaltransformhilbertFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertFrame::to_string(self : SignaltransformhilbertFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_table_make(size : Int) -> SignaltransformhilbertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertTable::len(self : SignaltransformhilbertTable) -> Int { self.size }

pub fn SignaltransformhilbertTable::get(self : SignaltransformhilbertTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertTable::set(self : SignaltransformhilbertTable, i : Int, v : Double) -> SignaltransformhilbertTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertTable::sum(self : SignaltransformhilbertTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertTable::mean(self : SignaltransformhilbertTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertTable::scale(self : SignaltransformhilbertTable, f : Double) -> SignaltransformhilbertTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertTable::add(self : SignaltransformhilbertTable, other : SignaltransformhilbertTable) -> SignaltransformhilbertTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertTable::copy(self : SignaltransformhilbertTable) -> SignaltransformhilbertTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertTable::fill(self : SignaltransformhilbertTable, v : Double) -> SignaltransformhilbertTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertTable::min(self : SignaltransformhilbertTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertTable::max(self : SignaltransformhilbertTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertTable::to_string(self : SignaltransformhilbertTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_graphn_make(size : Int) -> SignaltransformhilbertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertGraphN::len(self : SignaltransformhilbertGraphN) -> Int { self.size }

pub fn SignaltransformhilbertGraphN::get(self : SignaltransformhilbertGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertGraphN::set(self : SignaltransformhilbertGraphN, i : Int, v : Double) -> SignaltransformhilbertGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertGraphN::sum(self : SignaltransformhilbertGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertGraphN::mean(self : SignaltransformhilbertGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertGraphN::scale(self : SignaltransformhilbertGraphN, f : Double) -> SignaltransformhilbertGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertGraphN::add(self : SignaltransformhilbertGraphN, other : SignaltransformhilbertGraphN) -> SignaltransformhilbertGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertGraphN::copy(self : SignaltransformhilbertGraphN) -> SignaltransformhilbertGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertGraphN::fill(self : SignaltransformhilbertGraphN, v : Double) -> SignaltransformhilbertGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertGraphN::min(self : SignaltransformhilbertGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertGraphN::max(self : SignaltransformhilbertGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertGraphN::to_string(self : SignaltransformhilbertGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_node_make(size : Int) -> SignaltransformhilbertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertNode::len(self : SignaltransformhilbertNode) -> Int { self.size }

pub fn SignaltransformhilbertNode::get(self : SignaltransformhilbertNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertNode::set(self : SignaltransformhilbertNode, i : Int, v : Double) -> SignaltransformhilbertNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertNode::sum(self : SignaltransformhilbertNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertNode::mean(self : SignaltransformhilbertNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertNode::scale(self : SignaltransformhilbertNode, f : Double) -> SignaltransformhilbertNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertNode::add(self : SignaltransformhilbertNode, other : SignaltransformhilbertNode) -> SignaltransformhilbertNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertNode::copy(self : SignaltransformhilbertNode) -> SignaltransformhilbertNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertNode::fill(self : SignaltransformhilbertNode, v : Double) -> SignaltransformhilbertNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertNode::min(self : SignaltransformhilbertNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertNode::max(self : SignaltransformhilbertNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertNode::to_string(self : SignaltransformhilbertNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_edge_make(size : Int) -> SignaltransformhilbertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertEdge::len(self : SignaltransformhilbertEdge) -> Int { self.size }

pub fn SignaltransformhilbertEdge::get(self : SignaltransformhilbertEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertEdge::set(self : SignaltransformhilbertEdge, i : Int, v : Double) -> SignaltransformhilbertEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertEdge::sum(self : SignaltransformhilbertEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertEdge::mean(self : SignaltransformhilbertEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertEdge::scale(self : SignaltransformhilbertEdge, f : Double) -> SignaltransformhilbertEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertEdge::add(self : SignaltransformhilbertEdge, other : SignaltransformhilbertEdge) -> SignaltransformhilbertEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertEdge::copy(self : SignaltransformhilbertEdge) -> SignaltransformhilbertEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertEdge::fill(self : SignaltransformhilbertEdge, v : Double) -> SignaltransformhilbertEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertEdge::min(self : SignaltransformhilbertEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertEdge::max(self : SignaltransformhilbertEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertEdge::to_string(self : SignaltransformhilbertEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_path_make(size : Int) -> SignaltransformhilbertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertPath::len(self : SignaltransformhilbertPath) -> Int { self.size }

pub fn SignaltransformhilbertPath::get(self : SignaltransformhilbertPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertPath::set(self : SignaltransformhilbertPath, i : Int, v : Double) -> SignaltransformhilbertPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertPath::sum(self : SignaltransformhilbertPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertPath::mean(self : SignaltransformhilbertPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertPath::scale(self : SignaltransformhilbertPath, f : Double) -> SignaltransformhilbertPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertPath::add(self : SignaltransformhilbertPath, other : SignaltransformhilbertPath) -> SignaltransformhilbertPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertPath::copy(self : SignaltransformhilbertPath) -> SignaltransformhilbertPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertPath::fill(self : SignaltransformhilbertPath, v : Double) -> SignaltransformhilbertPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertPath::min(self : SignaltransformhilbertPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertPath::max(self : SignaltransformhilbertPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertPath::to_string(self : SignaltransformhilbertPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_cluster_make(size : Int) -> SignaltransformhilbertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertCluster::len(self : SignaltransformhilbertCluster) -> Int { self.size }

pub fn SignaltransformhilbertCluster::get(self : SignaltransformhilbertCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertCluster::set(self : SignaltransformhilbertCluster, i : Int, v : Double) -> SignaltransformhilbertCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertCluster::sum(self : SignaltransformhilbertCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertCluster::mean(self : SignaltransformhilbertCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertCluster::scale(self : SignaltransformhilbertCluster, f : Double) -> SignaltransformhilbertCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertCluster::add(self : SignaltransformhilbertCluster, other : SignaltransformhilbertCluster) -> SignaltransformhilbertCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertCluster::copy(self : SignaltransformhilbertCluster) -> SignaltransformhilbertCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertCluster::fill(self : SignaltransformhilbertCluster, v : Double) -> SignaltransformhilbertCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertCluster::min(self : SignaltransformhilbertCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertCluster::max(self : SignaltransformhilbertCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertCluster::to_string(self : SignaltransformhilbertCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_model_make(size : Int) -> SignaltransformhilbertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertModel::len(self : SignaltransformhilbertModel) -> Int { self.size }

pub fn SignaltransformhilbertModel::get(self : SignaltransformhilbertModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertModel::set(self : SignaltransformhilbertModel, i : Int, v : Double) -> SignaltransformhilbertModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertModel::sum(self : SignaltransformhilbertModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertModel::mean(self : SignaltransformhilbertModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertModel::scale(self : SignaltransformhilbertModel, f : Double) -> SignaltransformhilbertModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertModel::add(self : SignaltransformhilbertModel, other : SignaltransformhilbertModel) -> SignaltransformhilbertModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertModel::copy(self : SignaltransformhilbertModel) -> SignaltransformhilbertModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertModel::fill(self : SignaltransformhilbertModel, v : Double) -> SignaltransformhilbertModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertModel::min(self : SignaltransformhilbertModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertModel::max(self : SignaltransformhilbertModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertModel::to_string(self : SignaltransformhilbertModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_layer_make(size : Int) -> SignaltransformhilbertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertLayer::len(self : SignaltransformhilbertLayer) -> Int { self.size }

pub fn SignaltransformhilbertLayer::get(self : SignaltransformhilbertLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertLayer::set(self : SignaltransformhilbertLayer, i : Int, v : Double) -> SignaltransformhilbertLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertLayer::sum(self : SignaltransformhilbertLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertLayer::mean(self : SignaltransformhilbertLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertLayer::scale(self : SignaltransformhilbertLayer, f : Double) -> SignaltransformhilbertLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertLayer::add(self : SignaltransformhilbertLayer, other : SignaltransformhilbertLayer) -> SignaltransformhilbertLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertLayer::copy(self : SignaltransformhilbertLayer) -> SignaltransformhilbertLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertLayer::fill(self : SignaltransformhilbertLayer, v : Double) -> SignaltransformhilbertLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertLayer::min(self : SignaltransformhilbertLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertLayer::max(self : SignaltransformhilbertLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertLayer::to_string(self : SignaltransformhilbertLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_buffer_make(size : Int) -> SignaltransformhilbertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertBuffer::len(self : SignaltransformhilbertBuffer) -> Int { self.size }

pub fn SignaltransformhilbertBuffer::get(self : SignaltransformhilbertBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertBuffer::set(self : SignaltransformhilbertBuffer, i : Int, v : Double) -> SignaltransformhilbertBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertBuffer::sum(self : SignaltransformhilbertBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertBuffer::mean(self : SignaltransformhilbertBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertBuffer::scale(self : SignaltransformhilbertBuffer, f : Double) -> SignaltransformhilbertBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertBuffer::add(self : SignaltransformhilbertBuffer, other : SignaltransformhilbertBuffer) -> SignaltransformhilbertBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertBuffer::copy(self : SignaltransformhilbertBuffer) -> SignaltransformhilbertBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertBuffer::fill(self : SignaltransformhilbertBuffer, v : Double) -> SignaltransformhilbertBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertBuffer::min(self : SignaltransformhilbertBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertBuffer::max(self : SignaltransformhilbertBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertBuffer::to_string(self : SignaltransformhilbertBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_cursor_make(size : Int) -> SignaltransformhilbertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertCursor::len(self : SignaltransformhilbertCursor) -> Int { self.size }

pub fn SignaltransformhilbertCursor::get(self : SignaltransformhilbertCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertCursor::set(self : SignaltransformhilbertCursor, i : Int, v : Double) -> SignaltransformhilbertCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertCursor::sum(self : SignaltransformhilbertCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertCursor::mean(self : SignaltransformhilbertCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertCursor::scale(self : SignaltransformhilbertCursor, f : Double) -> SignaltransformhilbertCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertCursor::add(self : SignaltransformhilbertCursor, other : SignaltransformhilbertCursor) -> SignaltransformhilbertCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertCursor::copy(self : SignaltransformhilbertCursor) -> SignaltransformhilbertCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertCursor::fill(self : SignaltransformhilbertCursor, v : Double) -> SignaltransformhilbertCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertCursor::min(self : SignaltransformhilbertCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertCursor::max(self : SignaltransformhilbertCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertCursor::to_string(self : SignaltransformhilbertCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_view_make(size : Int) -> SignaltransformhilbertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertView::len(self : SignaltransformhilbertView) -> Int { self.size }

pub fn SignaltransformhilbertView::get(self : SignaltransformhilbertView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertView::set(self : SignaltransformhilbertView, i : Int, v : Double) -> SignaltransformhilbertView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertView::sum(self : SignaltransformhilbertView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertView::mean(self : SignaltransformhilbertView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertView::scale(self : SignaltransformhilbertView, f : Double) -> SignaltransformhilbertView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertView::add(self : SignaltransformhilbertView, other : SignaltransformhilbertView) -> SignaltransformhilbertView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertView::copy(self : SignaltransformhilbertView) -> SignaltransformhilbertView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertView::fill(self : SignaltransformhilbertView, v : Double) -> SignaltransformhilbertView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertView::min(self : SignaltransformhilbertView) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertView::max(self : SignaltransformhilbertView) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertView::to_string(self : SignaltransformhilbertView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_range_make(size : Int) -> SignaltransformhilbertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertRange::len(self : SignaltransformhilbertRange) -> Int { self.size }

pub fn SignaltransformhilbertRange::get(self : SignaltransformhilbertRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertRange::set(self : SignaltransformhilbertRange, i : Int, v : Double) -> SignaltransformhilbertRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertRange::sum(self : SignaltransformhilbertRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertRange::mean(self : SignaltransformhilbertRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertRange::scale(self : SignaltransformhilbertRange, f : Double) -> SignaltransformhilbertRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertRange::add(self : SignaltransformhilbertRange, other : SignaltransformhilbertRange) -> SignaltransformhilbertRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertRange::copy(self : SignaltransformhilbertRange) -> SignaltransformhilbertRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertRange::fill(self : SignaltransformhilbertRange, v : Double) -> SignaltransformhilbertRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertRange::min(self : SignaltransformhilbertRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertRange::max(self : SignaltransformhilbertRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertRange::to_string(self : SignaltransformhilbertRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_slice_make(size : Int) -> SignaltransformhilbertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformhilbertSlice::len(self : SignaltransformhilbertSlice) -> Int { self.size }

pub fn SignaltransformhilbertSlice::get(self : SignaltransformhilbertSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformhilbertSlice::set(self : SignaltransformhilbertSlice, i : Int, v : Double) -> SignaltransformhilbertSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertSlice::sum(self : SignaltransformhilbertSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformhilbertSlice::mean(self : SignaltransformhilbertSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformhilbertSlice::scale(self : SignaltransformhilbertSlice, f : Double) -> SignaltransformhilbertSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertSlice::add(self : SignaltransformhilbertSlice, other : SignaltransformhilbertSlice) -> SignaltransformhilbertSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformhilbertSlice::copy(self : SignaltransformhilbertSlice) -> SignaltransformhilbertSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertSlice::fill(self : SignaltransformhilbertSlice, v : Double) -> SignaltransformhilbertSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformhilbertSlice::min(self : SignaltransformhilbertSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformhilbertSlice::max(self : SignaltransformhilbertSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformhilbertSlice::to_string(self : SignaltransformhilbertSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

