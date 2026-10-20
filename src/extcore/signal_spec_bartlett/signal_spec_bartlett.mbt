///===
/// extcore/signal_spec_bartlett

pub(all) struct SignalspecbartlettPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_bartlett_make_point(x : Double, y : Double) -> SignalspecbartlettPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_bartlett_make_point3(x : Double, y : Double, z : Double) -> SignalspecbartlettPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecbartlettPoint::x(self : SignalspecbartlettPoint) -> Double { self.x }

pub fn SignalspecbartlettPoint::y(self : SignalspecbartlettPoint) -> Double { self.y }

pub fn SignalspecbartlettPoint::z(self : SignalspecbartlettPoint) -> Double { self.z }

pub fn SignalspecbartlettPoint::label(self : SignalspecbartlettPoint) -> Int { self.label }

pub fn SignalspecbartlettPoint::dist(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecbartlettPoint::add(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecbartlettPoint::sub(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecbartlettPoint::scale(self : SignalspecbartlettPoint, s : Double) -> SignalspecbartlettPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecbartlettPoint::dot(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecbartlettPoint::cross(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecbartlettPoint::norm(self : SignalspecbartlettPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecbartlettPoint::normalize(self : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecbartlettPoint::negate(self : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecbartlettPoint::mid(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecbartlettPoint::lerp(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint, t : Double) -> SignalspecbartlettPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecbartlettPoint::to_string(self : SignalspecbartlettPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecbartlettSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_bartlett_make_series(vals : Array[Double], name : String) -> SignalspecbartlettSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecbartlettSeries::len(self : SignalspecbartlettSeries) -> Int { self.vals.length() }

pub fn SignalspecbartlettSeries::sum(self : SignalspecbartlettSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecbartlettSeries::mean(self : SignalspecbartlettSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecbartlettSeries::min(self : SignalspecbartlettSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecbartlettSeries::max(self : SignalspecbartlettSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecbartlettSeries::range(self : SignalspecbartlettSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecbartlettSeries::variance(self : SignalspecbartlettSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecbartlettSeries::std(self : SignalspecbartlettSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecbartlettSeries::median(self : SignalspecbartlettSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecbartlettSeries::scale(self : SignalspecbartlettSeries, f : Double) -> SignalspecbartlettSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecbartlettSeries::add(self : SignalspecbartlettSeries, other : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecbartlettSeries::sub(self : SignalspecbartlettSeries, other : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecbartlettSeries::normalize(self : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecbartlettSeries::cumsum(self : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecbartlettSeries::to_string(self : SignalspecbartlettSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecbartlettMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_bartlett_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecbartlettMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_spec_bartlett_matrix_identity(n : Int) -> SignalspecbartlettMatrix {
  let m = signal_spec_bartlett_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecbartlettMatrix::get(self : SignalspecbartlettMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecbartlettMatrix::transpose(self : SignalspecbartlettMatrix) -> SignalspecbartlettMatrix {
  let result = signal_spec_bartlett_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecbartlettMatrix::add(self : SignalspecbartlettMatrix, other : SignalspecbartlettMatrix) -> SignalspecbartlettMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_bartlett_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecbartlettMatrix::scale(self : SignalspecbartlettMatrix, s : Double) -> SignalspecbartlettMatrix {
  let result = signal_spec_bartlett_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecbartlettMatrix::multiply(self : SignalspecbartlettMatrix, other : SignalspecbartlettMatrix) -> SignalspecbartlettMatrix {
  if self.cols != other.rows { return signal_spec_bartlett_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_bartlett_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalspecbartlettMatrix::trace(self : SignalspecbartlettMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecbartlettMatrix::det(self : SignalspecbartlettMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecbartlettMatrix::norm(self : SignalspecbartlettMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecbartlettMatrix::to_string(self : SignalspecbartlettMatrix) -> String {
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

pub(all) struct SignalspecbartlettVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_bartlett_make_vector(comps : Array[Double]) -> SignalspecbartlettVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_bartlett_vector_zero(dim : Int) -> SignalspecbartlettVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecbartlettVector::add(self : SignalspecbartlettVector, other : SignalspecbartlettVector) -> SignalspecbartlettVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecbartlettVector::sub(self : SignalspecbartlettVector, other : SignalspecbartlettVector) -> SignalspecbartlettVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecbartlettVector::scale(self : SignalspecbartlettVector, s : Double) -> SignalspecbartlettVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecbartlettVector::dot(self : SignalspecbartlettVector, other : SignalspecbartlettVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecbartlettVector::norm(self : SignalspecbartlettVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecbartlettVector::normalize(self : SignalspecbartlettVector) -> SignalspecbartlettVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecbartlettVector::dist(self : SignalspecbartlettVector, other : SignalspecbartlettVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecbartlettVector::to_string(self : SignalspecbartlettVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecbartlettFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_frame_make(size : Int) -> SignalspecbartlettFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettFrame::len(self : SignalspecbartlettFrame) -> Int { self.size }

pub fn SignalspecbartlettFrame::get(self : SignalspecbartlettFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettFrame::set(self : SignalspecbartlettFrame, i : Int, v : Double) -> SignalspecbartlettFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettFrame::sum(self : SignalspecbartlettFrame) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettFrame::mean(self : SignalspecbartlettFrame) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettFrame::scale(self : SignalspecbartlettFrame, f : Double) -> SignalspecbartlettFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettFrame::add(self : SignalspecbartlettFrame, other : SignalspecbartlettFrame) -> SignalspecbartlettFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettFrame::copy(self : SignalspecbartlettFrame) -> SignalspecbartlettFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettFrame::fill(self : SignalspecbartlettFrame, v : Double) -> SignalspecbartlettFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettFrame::min(self : SignalspecbartlettFrame) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettFrame::max(self : SignalspecbartlettFrame) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettFrame::to_string(self : SignalspecbartlettFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_table_make(size : Int) -> SignalspecbartlettTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettTable::len(self : SignalspecbartlettTable) -> Int { self.size }

pub fn SignalspecbartlettTable::get(self : SignalspecbartlettTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettTable::set(self : SignalspecbartlettTable, i : Int, v : Double) -> SignalspecbartlettTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettTable::sum(self : SignalspecbartlettTable) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettTable::mean(self : SignalspecbartlettTable) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettTable::scale(self : SignalspecbartlettTable, f : Double) -> SignalspecbartlettTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettTable::add(self : SignalspecbartlettTable, other : SignalspecbartlettTable) -> SignalspecbartlettTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettTable::copy(self : SignalspecbartlettTable) -> SignalspecbartlettTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettTable::fill(self : SignalspecbartlettTable, v : Double) -> SignalspecbartlettTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettTable::min(self : SignalspecbartlettTable) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettTable::max(self : SignalspecbartlettTable) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettTable::to_string(self : SignalspecbartlettTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_graphn_make(size : Int) -> SignalspecbartlettGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettGraphN::len(self : SignalspecbartlettGraphN) -> Int { self.size }

pub fn SignalspecbartlettGraphN::get(self : SignalspecbartlettGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettGraphN::set(self : SignalspecbartlettGraphN, i : Int, v : Double) -> SignalspecbartlettGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettGraphN::sum(self : SignalspecbartlettGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettGraphN::mean(self : SignalspecbartlettGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettGraphN::scale(self : SignalspecbartlettGraphN, f : Double) -> SignalspecbartlettGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettGraphN::add(self : SignalspecbartlettGraphN, other : SignalspecbartlettGraphN) -> SignalspecbartlettGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettGraphN::copy(self : SignalspecbartlettGraphN) -> SignalspecbartlettGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettGraphN::fill(self : SignalspecbartlettGraphN, v : Double) -> SignalspecbartlettGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettGraphN::min(self : SignalspecbartlettGraphN) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettGraphN::max(self : SignalspecbartlettGraphN) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettGraphN::to_string(self : SignalspecbartlettGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_node_make(size : Int) -> SignalspecbartlettNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettNode::len(self : SignalspecbartlettNode) -> Int { self.size }

pub fn SignalspecbartlettNode::get(self : SignalspecbartlettNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettNode::set(self : SignalspecbartlettNode, i : Int, v : Double) -> SignalspecbartlettNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettNode::sum(self : SignalspecbartlettNode) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettNode::mean(self : SignalspecbartlettNode) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettNode::scale(self : SignalspecbartlettNode, f : Double) -> SignalspecbartlettNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettNode::add(self : SignalspecbartlettNode, other : SignalspecbartlettNode) -> SignalspecbartlettNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettNode::copy(self : SignalspecbartlettNode) -> SignalspecbartlettNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettNode::fill(self : SignalspecbartlettNode, v : Double) -> SignalspecbartlettNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettNode::min(self : SignalspecbartlettNode) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettNode::max(self : SignalspecbartlettNode) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettNode::to_string(self : SignalspecbartlettNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_edge_make(size : Int) -> SignalspecbartlettEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettEdge::len(self : SignalspecbartlettEdge) -> Int { self.size }

pub fn SignalspecbartlettEdge::get(self : SignalspecbartlettEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettEdge::set(self : SignalspecbartlettEdge, i : Int, v : Double) -> SignalspecbartlettEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettEdge::sum(self : SignalspecbartlettEdge) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettEdge::mean(self : SignalspecbartlettEdge) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettEdge::scale(self : SignalspecbartlettEdge, f : Double) -> SignalspecbartlettEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettEdge::add(self : SignalspecbartlettEdge, other : SignalspecbartlettEdge) -> SignalspecbartlettEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettEdge::copy(self : SignalspecbartlettEdge) -> SignalspecbartlettEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettEdge::fill(self : SignalspecbartlettEdge, v : Double) -> SignalspecbartlettEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettEdge::min(self : SignalspecbartlettEdge) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettEdge::max(self : SignalspecbartlettEdge) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettEdge::to_string(self : SignalspecbartlettEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_path_make(size : Int) -> SignalspecbartlettPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettPath::len(self : SignalspecbartlettPath) -> Int { self.size }

pub fn SignalspecbartlettPath::get(self : SignalspecbartlettPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettPath::set(self : SignalspecbartlettPath, i : Int, v : Double) -> SignalspecbartlettPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettPath::sum(self : SignalspecbartlettPath) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettPath::mean(self : SignalspecbartlettPath) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettPath::scale(self : SignalspecbartlettPath, f : Double) -> SignalspecbartlettPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettPath::add(self : SignalspecbartlettPath, other : SignalspecbartlettPath) -> SignalspecbartlettPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettPath::copy(self : SignalspecbartlettPath) -> SignalspecbartlettPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettPath::fill(self : SignalspecbartlettPath, v : Double) -> SignalspecbartlettPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettPath::min(self : SignalspecbartlettPath) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettPath::max(self : SignalspecbartlettPath) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettPath::to_string(self : SignalspecbartlettPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_cluster_make(size : Int) -> SignalspecbartlettCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettCluster::len(self : SignalspecbartlettCluster) -> Int { self.size }

pub fn SignalspecbartlettCluster::get(self : SignalspecbartlettCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettCluster::set(self : SignalspecbartlettCluster, i : Int, v : Double) -> SignalspecbartlettCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettCluster::sum(self : SignalspecbartlettCluster) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettCluster::mean(self : SignalspecbartlettCluster) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettCluster::scale(self : SignalspecbartlettCluster, f : Double) -> SignalspecbartlettCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettCluster::add(self : SignalspecbartlettCluster, other : SignalspecbartlettCluster) -> SignalspecbartlettCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettCluster::copy(self : SignalspecbartlettCluster) -> SignalspecbartlettCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettCluster::fill(self : SignalspecbartlettCluster, v : Double) -> SignalspecbartlettCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettCluster::min(self : SignalspecbartlettCluster) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettCluster::max(self : SignalspecbartlettCluster) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettCluster::to_string(self : SignalspecbartlettCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_model_make(size : Int) -> SignalspecbartlettModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettModel::len(self : SignalspecbartlettModel) -> Int { self.size }

pub fn SignalspecbartlettModel::get(self : SignalspecbartlettModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettModel::set(self : SignalspecbartlettModel, i : Int, v : Double) -> SignalspecbartlettModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettModel::sum(self : SignalspecbartlettModel) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettModel::mean(self : SignalspecbartlettModel) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettModel::scale(self : SignalspecbartlettModel, f : Double) -> SignalspecbartlettModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettModel::add(self : SignalspecbartlettModel, other : SignalspecbartlettModel) -> SignalspecbartlettModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettModel::copy(self : SignalspecbartlettModel) -> SignalspecbartlettModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettModel::fill(self : SignalspecbartlettModel, v : Double) -> SignalspecbartlettModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettModel::min(self : SignalspecbartlettModel) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettModel::max(self : SignalspecbartlettModel) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettModel::to_string(self : SignalspecbartlettModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_layer_make(size : Int) -> SignalspecbartlettLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettLayer::len(self : SignalspecbartlettLayer) -> Int { self.size }

pub fn SignalspecbartlettLayer::get(self : SignalspecbartlettLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettLayer::set(self : SignalspecbartlettLayer, i : Int, v : Double) -> SignalspecbartlettLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettLayer::sum(self : SignalspecbartlettLayer) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettLayer::mean(self : SignalspecbartlettLayer) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettLayer::scale(self : SignalspecbartlettLayer, f : Double) -> SignalspecbartlettLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettLayer::add(self : SignalspecbartlettLayer, other : SignalspecbartlettLayer) -> SignalspecbartlettLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettLayer::copy(self : SignalspecbartlettLayer) -> SignalspecbartlettLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettLayer::fill(self : SignalspecbartlettLayer, v : Double) -> SignalspecbartlettLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettLayer::min(self : SignalspecbartlettLayer) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettLayer::max(self : SignalspecbartlettLayer) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettLayer::to_string(self : SignalspecbartlettLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_buffer_make(size : Int) -> SignalspecbartlettBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettBuffer::len(self : SignalspecbartlettBuffer) -> Int { self.size }

pub fn SignalspecbartlettBuffer::get(self : SignalspecbartlettBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettBuffer::set(self : SignalspecbartlettBuffer, i : Int, v : Double) -> SignalspecbartlettBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettBuffer::sum(self : SignalspecbartlettBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettBuffer::mean(self : SignalspecbartlettBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettBuffer::scale(self : SignalspecbartlettBuffer, f : Double) -> SignalspecbartlettBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettBuffer::add(self : SignalspecbartlettBuffer, other : SignalspecbartlettBuffer) -> SignalspecbartlettBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettBuffer::copy(self : SignalspecbartlettBuffer) -> SignalspecbartlettBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettBuffer::fill(self : SignalspecbartlettBuffer, v : Double) -> SignalspecbartlettBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettBuffer::min(self : SignalspecbartlettBuffer) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettBuffer::max(self : SignalspecbartlettBuffer) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettBuffer::to_string(self : SignalspecbartlettBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_cursor_make(size : Int) -> SignalspecbartlettCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettCursor::len(self : SignalspecbartlettCursor) -> Int { self.size }

pub fn SignalspecbartlettCursor::get(self : SignalspecbartlettCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettCursor::set(self : SignalspecbartlettCursor, i : Int, v : Double) -> SignalspecbartlettCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettCursor::sum(self : SignalspecbartlettCursor) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettCursor::mean(self : SignalspecbartlettCursor) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettCursor::scale(self : SignalspecbartlettCursor, f : Double) -> SignalspecbartlettCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettCursor::add(self : SignalspecbartlettCursor, other : SignalspecbartlettCursor) -> SignalspecbartlettCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettCursor::copy(self : SignalspecbartlettCursor) -> SignalspecbartlettCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettCursor::fill(self : SignalspecbartlettCursor, v : Double) -> SignalspecbartlettCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettCursor::min(self : SignalspecbartlettCursor) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettCursor::max(self : SignalspecbartlettCursor) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettCursor::to_string(self : SignalspecbartlettCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_view_make(size : Int) -> SignalspecbartlettView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettView::len(self : SignalspecbartlettView) -> Int { self.size }

pub fn SignalspecbartlettView::get(self : SignalspecbartlettView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettView::set(self : SignalspecbartlettView, i : Int, v : Double) -> SignalspecbartlettView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettView::sum(self : SignalspecbartlettView) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettView::mean(self : SignalspecbartlettView) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettView::scale(self : SignalspecbartlettView, f : Double) -> SignalspecbartlettView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettView::add(self : SignalspecbartlettView, other : SignalspecbartlettView) -> SignalspecbartlettView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettView::copy(self : SignalspecbartlettView) -> SignalspecbartlettView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettView::fill(self : SignalspecbartlettView, v : Double) -> SignalspecbartlettView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettView::min(self : SignalspecbartlettView) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettView::max(self : SignalspecbartlettView) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettView::to_string(self : SignalspecbartlettView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_range_make(size : Int) -> SignalspecbartlettRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettRange::len(self : SignalspecbartlettRange) -> Int { self.size }

pub fn SignalspecbartlettRange::get(self : SignalspecbartlettRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettRange::set(self : SignalspecbartlettRange, i : Int, v : Double) -> SignalspecbartlettRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettRange::sum(self : SignalspecbartlettRange) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettRange::mean(self : SignalspecbartlettRange) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettRange::scale(self : SignalspecbartlettRange, f : Double) -> SignalspecbartlettRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettRange::add(self : SignalspecbartlettRange, other : SignalspecbartlettRange) -> SignalspecbartlettRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettRange::copy(self : SignalspecbartlettRange) -> SignalspecbartlettRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettRange::fill(self : SignalspecbartlettRange, v : Double) -> SignalspecbartlettRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettRange::min(self : SignalspecbartlettRange) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettRange::max(self : SignalspecbartlettRange) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettRange::to_string(self : SignalspecbartlettRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_slice_make(size : Int) -> SignalspecbartlettSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecbartlettSlice::len(self : SignalspecbartlettSlice) -> Int { self.size }

pub fn SignalspecbartlettSlice::get(self : SignalspecbartlettSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecbartlettSlice::set(self : SignalspecbartlettSlice, i : Int, v : Double) -> SignalspecbartlettSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettSlice::sum(self : SignalspecbartlettSlice) -> Double { @_common.sum(self.data) }

pub fn SignalspecbartlettSlice::mean(self : SignalspecbartlettSlice) -> Double { @_common.mean(self.data) }

pub fn SignalspecbartlettSlice::scale(self : SignalspecbartlettSlice, f : Double) -> SignalspecbartlettSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettSlice::add(self : SignalspecbartlettSlice, other : SignalspecbartlettSlice) -> SignalspecbartlettSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecbartlettSlice::copy(self : SignalspecbartlettSlice) -> SignalspecbartlettSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettSlice::fill(self : SignalspecbartlettSlice, v : Double) -> SignalspecbartlettSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecbartlettSlice::min(self : SignalspecbartlettSlice) -> Double { @_common.min(self.data) }

pub fn SignalspecbartlettSlice::max(self : SignalspecbartlettSlice) -> Double { @_common.max(self.data) }

pub fn SignalspecbartlettSlice::to_string(self : SignalspecbartlettSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

