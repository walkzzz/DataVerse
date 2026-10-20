///===
/// extcore/timeseries_decomp_vmd

pub(all) struct TimeseriesdecompvmdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_vmd_make_point(x : Double, y : Double) -> TimeseriesdecompvmdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_vmd_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompvmdPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompvmdPoint::x(self : TimeseriesdecompvmdPoint) -> Double { self.x }

pub fn TimeseriesdecompvmdPoint::y(self : TimeseriesdecompvmdPoint) -> Double { self.y }

pub fn TimeseriesdecompvmdPoint::z(self : TimeseriesdecompvmdPoint) -> Double { self.z }

pub fn TimeseriesdecompvmdPoint::label(self : TimeseriesdecompvmdPoint) -> Int { self.label }

pub fn TimeseriesdecompvmdPoint::dist(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompvmdPoint::add(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::sub(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::scale(self : TimeseriesdecompvmdPoint, s : Double) -> TimeseriesdecompvmdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::dot(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompvmdPoint::cross(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompvmdPoint::norm(self : TimeseriesdecompvmdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompvmdPoint::normalize(self : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompvmdPoint::negate(self : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::mid(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::lerp(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint, t : Double) -> TimeseriesdecompvmdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::to_string(self : TimeseriesdecompvmdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_vmd_make_series(vals : Array[Double], name : String) -> TimeseriesdecompvmdSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompvmdSeries::len(self : TimeseriesdecompvmdSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompvmdSeries::sum(self : TimeseriesdecompvmdSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompvmdSeries::mean(self : TimeseriesdecompvmdSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompvmdSeries::min(self : TimeseriesdecompvmdSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompvmdSeries::max(self : TimeseriesdecompvmdSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompvmdSeries::range(self : TimeseriesdecompvmdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompvmdSeries::variance(self : TimeseriesdecompvmdSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompvmdSeries::std(self : TimeseriesdecompvmdSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompvmdSeries::median(self : TimeseriesdecompvmdSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompvmdSeries::scale(self : TimeseriesdecompvmdSeries, f : Double) -> TimeseriesdecompvmdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompvmdSeries::add(self : TimeseriesdecompvmdSeries, other : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompvmdSeries::sub(self : TimeseriesdecompvmdSeries, other : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompvmdSeries::normalize(self : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompvmdSeries::cumsum(self : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompvmdSeries::to_string(self : TimeseriesdecompvmdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompvmdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_vmd_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompvmdMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn timeseries_decomp_vmd_matrix_identity(n : Int) -> TimeseriesdecompvmdMatrix {
  let m = timeseries_decomp_vmd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompvmdMatrix::get(self : TimeseriesdecompvmdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompvmdMatrix::transpose(self : TimeseriesdecompvmdMatrix) -> TimeseriesdecompvmdMatrix {
  let result = timeseries_decomp_vmd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompvmdMatrix::add(self : TimeseriesdecompvmdMatrix, other : TimeseriesdecompvmdMatrix) -> TimeseriesdecompvmdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_vmd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompvmdMatrix::scale(self : TimeseriesdecompvmdMatrix, s : Double) -> TimeseriesdecompvmdMatrix {
  let result = timeseries_decomp_vmd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompvmdMatrix::multiply(self : TimeseriesdecompvmdMatrix, other : TimeseriesdecompvmdMatrix) -> TimeseriesdecompvmdMatrix {
  if self.cols != other.rows { return timeseries_decomp_vmd_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_vmd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesdecompvmdMatrix::trace(self : TimeseriesdecompvmdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompvmdMatrix::det(self : TimeseriesdecompvmdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompvmdMatrix::norm(self : TimeseriesdecompvmdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompvmdMatrix::to_string(self : TimeseriesdecompvmdMatrix) -> String {
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

pub(all) struct TimeseriesdecompvmdVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_vmd_make_vector(comps : Array[Double]) -> TimeseriesdecompvmdVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_vmd_vector_zero(dim : Int) -> TimeseriesdecompvmdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompvmdVector::add(self : TimeseriesdecompvmdVector, other : TimeseriesdecompvmdVector) -> TimeseriesdecompvmdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompvmdVector::sub(self : TimeseriesdecompvmdVector, other : TimeseriesdecompvmdVector) -> TimeseriesdecompvmdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompvmdVector::scale(self : TimeseriesdecompvmdVector, s : Double) -> TimeseriesdecompvmdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompvmdVector::dot(self : TimeseriesdecompvmdVector, other : TimeseriesdecompvmdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompvmdVector::norm(self : TimeseriesdecompvmdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompvmdVector::normalize(self : TimeseriesdecompvmdVector) -> TimeseriesdecompvmdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompvmdVector::dist(self : TimeseriesdecompvmdVector, other : TimeseriesdecompvmdVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompvmdVector::to_string(self : TimeseriesdecompvmdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompvmdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_frame_make(size : Int) -> TimeseriesdecompvmdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdFrame::len(self : TimeseriesdecompvmdFrame) -> Int { self.size }

pub fn TimeseriesdecompvmdFrame::get(self : TimeseriesdecompvmdFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdFrame::set(self : TimeseriesdecompvmdFrame, i : Int, v : Double) -> TimeseriesdecompvmdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdFrame::sum(self : TimeseriesdecompvmdFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdFrame::mean(self : TimeseriesdecompvmdFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdFrame::scale(self : TimeseriesdecompvmdFrame, f : Double) -> TimeseriesdecompvmdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdFrame::add(self : TimeseriesdecompvmdFrame, other : TimeseriesdecompvmdFrame) -> TimeseriesdecompvmdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdFrame::copy(self : TimeseriesdecompvmdFrame) -> TimeseriesdecompvmdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdFrame::fill(self : TimeseriesdecompvmdFrame, v : Double) -> TimeseriesdecompvmdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdFrame::min(self : TimeseriesdecompvmdFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdFrame::max(self : TimeseriesdecompvmdFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdFrame::to_string(self : TimeseriesdecompvmdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_table_make(size : Int) -> TimeseriesdecompvmdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdTable::len(self : TimeseriesdecompvmdTable) -> Int { self.size }

pub fn TimeseriesdecompvmdTable::get(self : TimeseriesdecompvmdTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdTable::set(self : TimeseriesdecompvmdTable, i : Int, v : Double) -> TimeseriesdecompvmdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdTable::sum(self : TimeseriesdecompvmdTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdTable::mean(self : TimeseriesdecompvmdTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdTable::scale(self : TimeseriesdecompvmdTable, f : Double) -> TimeseriesdecompvmdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdTable::add(self : TimeseriesdecompvmdTable, other : TimeseriesdecompvmdTable) -> TimeseriesdecompvmdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdTable::copy(self : TimeseriesdecompvmdTable) -> TimeseriesdecompvmdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdTable::fill(self : TimeseriesdecompvmdTable, v : Double) -> TimeseriesdecompvmdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdTable::min(self : TimeseriesdecompvmdTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdTable::max(self : TimeseriesdecompvmdTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdTable::to_string(self : TimeseriesdecompvmdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_graphn_make(size : Int) -> TimeseriesdecompvmdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdGraphN::len(self : TimeseriesdecompvmdGraphN) -> Int { self.size }

pub fn TimeseriesdecompvmdGraphN::get(self : TimeseriesdecompvmdGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdGraphN::set(self : TimeseriesdecompvmdGraphN, i : Int, v : Double) -> TimeseriesdecompvmdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdGraphN::sum(self : TimeseriesdecompvmdGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdGraphN::mean(self : TimeseriesdecompvmdGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdGraphN::scale(self : TimeseriesdecompvmdGraphN, f : Double) -> TimeseriesdecompvmdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdGraphN::add(self : TimeseriesdecompvmdGraphN, other : TimeseriesdecompvmdGraphN) -> TimeseriesdecompvmdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdGraphN::copy(self : TimeseriesdecompvmdGraphN) -> TimeseriesdecompvmdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdGraphN::fill(self : TimeseriesdecompvmdGraphN, v : Double) -> TimeseriesdecompvmdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdGraphN::min(self : TimeseriesdecompvmdGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdGraphN::max(self : TimeseriesdecompvmdGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdGraphN::to_string(self : TimeseriesdecompvmdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_node_make(size : Int) -> TimeseriesdecompvmdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdNode::len(self : TimeseriesdecompvmdNode) -> Int { self.size }

pub fn TimeseriesdecompvmdNode::get(self : TimeseriesdecompvmdNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdNode::set(self : TimeseriesdecompvmdNode, i : Int, v : Double) -> TimeseriesdecompvmdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdNode::sum(self : TimeseriesdecompvmdNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdNode::mean(self : TimeseriesdecompvmdNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdNode::scale(self : TimeseriesdecompvmdNode, f : Double) -> TimeseriesdecompvmdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdNode::add(self : TimeseriesdecompvmdNode, other : TimeseriesdecompvmdNode) -> TimeseriesdecompvmdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdNode::copy(self : TimeseriesdecompvmdNode) -> TimeseriesdecompvmdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdNode::fill(self : TimeseriesdecompvmdNode, v : Double) -> TimeseriesdecompvmdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdNode::min(self : TimeseriesdecompvmdNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdNode::max(self : TimeseriesdecompvmdNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdNode::to_string(self : TimeseriesdecompvmdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_edge_make(size : Int) -> TimeseriesdecompvmdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdEdge::len(self : TimeseriesdecompvmdEdge) -> Int { self.size }

pub fn TimeseriesdecompvmdEdge::get(self : TimeseriesdecompvmdEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdEdge::set(self : TimeseriesdecompvmdEdge, i : Int, v : Double) -> TimeseriesdecompvmdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdEdge::sum(self : TimeseriesdecompvmdEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdEdge::mean(self : TimeseriesdecompvmdEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdEdge::scale(self : TimeseriesdecompvmdEdge, f : Double) -> TimeseriesdecompvmdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdEdge::add(self : TimeseriesdecompvmdEdge, other : TimeseriesdecompvmdEdge) -> TimeseriesdecompvmdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdEdge::copy(self : TimeseriesdecompvmdEdge) -> TimeseriesdecompvmdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdEdge::fill(self : TimeseriesdecompvmdEdge, v : Double) -> TimeseriesdecompvmdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdEdge::min(self : TimeseriesdecompvmdEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdEdge::max(self : TimeseriesdecompvmdEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdEdge::to_string(self : TimeseriesdecompvmdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_path_make(size : Int) -> TimeseriesdecompvmdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdPath::len(self : TimeseriesdecompvmdPath) -> Int { self.size }

pub fn TimeseriesdecompvmdPath::get(self : TimeseriesdecompvmdPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdPath::set(self : TimeseriesdecompvmdPath, i : Int, v : Double) -> TimeseriesdecompvmdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdPath::sum(self : TimeseriesdecompvmdPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdPath::mean(self : TimeseriesdecompvmdPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdPath::scale(self : TimeseriesdecompvmdPath, f : Double) -> TimeseriesdecompvmdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdPath::add(self : TimeseriesdecompvmdPath, other : TimeseriesdecompvmdPath) -> TimeseriesdecompvmdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdPath::copy(self : TimeseriesdecompvmdPath) -> TimeseriesdecompvmdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdPath::fill(self : TimeseriesdecompvmdPath, v : Double) -> TimeseriesdecompvmdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdPath::min(self : TimeseriesdecompvmdPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdPath::max(self : TimeseriesdecompvmdPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdPath::to_string(self : TimeseriesdecompvmdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_cluster_make(size : Int) -> TimeseriesdecompvmdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdCluster::len(self : TimeseriesdecompvmdCluster) -> Int { self.size }

pub fn TimeseriesdecompvmdCluster::get(self : TimeseriesdecompvmdCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdCluster::set(self : TimeseriesdecompvmdCluster, i : Int, v : Double) -> TimeseriesdecompvmdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdCluster::sum(self : TimeseriesdecompvmdCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdCluster::mean(self : TimeseriesdecompvmdCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdCluster::scale(self : TimeseriesdecompvmdCluster, f : Double) -> TimeseriesdecompvmdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdCluster::add(self : TimeseriesdecompvmdCluster, other : TimeseriesdecompvmdCluster) -> TimeseriesdecompvmdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdCluster::copy(self : TimeseriesdecompvmdCluster) -> TimeseriesdecompvmdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdCluster::fill(self : TimeseriesdecompvmdCluster, v : Double) -> TimeseriesdecompvmdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdCluster::min(self : TimeseriesdecompvmdCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdCluster::max(self : TimeseriesdecompvmdCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdCluster::to_string(self : TimeseriesdecompvmdCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_model_make(size : Int) -> TimeseriesdecompvmdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdModel::len(self : TimeseriesdecompvmdModel) -> Int { self.size }

pub fn TimeseriesdecompvmdModel::get(self : TimeseriesdecompvmdModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdModel::set(self : TimeseriesdecompvmdModel, i : Int, v : Double) -> TimeseriesdecompvmdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdModel::sum(self : TimeseriesdecompvmdModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdModel::mean(self : TimeseriesdecompvmdModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdModel::scale(self : TimeseriesdecompvmdModel, f : Double) -> TimeseriesdecompvmdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdModel::add(self : TimeseriesdecompvmdModel, other : TimeseriesdecompvmdModel) -> TimeseriesdecompvmdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdModel::copy(self : TimeseriesdecompvmdModel) -> TimeseriesdecompvmdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdModel::fill(self : TimeseriesdecompvmdModel, v : Double) -> TimeseriesdecompvmdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdModel::min(self : TimeseriesdecompvmdModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdModel::max(self : TimeseriesdecompvmdModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdModel::to_string(self : TimeseriesdecompvmdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_layer_make(size : Int) -> TimeseriesdecompvmdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdLayer::len(self : TimeseriesdecompvmdLayer) -> Int { self.size }

pub fn TimeseriesdecompvmdLayer::get(self : TimeseriesdecompvmdLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdLayer::set(self : TimeseriesdecompvmdLayer, i : Int, v : Double) -> TimeseriesdecompvmdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdLayer::sum(self : TimeseriesdecompvmdLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdLayer::mean(self : TimeseriesdecompvmdLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdLayer::scale(self : TimeseriesdecompvmdLayer, f : Double) -> TimeseriesdecompvmdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdLayer::add(self : TimeseriesdecompvmdLayer, other : TimeseriesdecompvmdLayer) -> TimeseriesdecompvmdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdLayer::copy(self : TimeseriesdecompvmdLayer) -> TimeseriesdecompvmdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdLayer::fill(self : TimeseriesdecompvmdLayer, v : Double) -> TimeseriesdecompvmdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdLayer::min(self : TimeseriesdecompvmdLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdLayer::max(self : TimeseriesdecompvmdLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdLayer::to_string(self : TimeseriesdecompvmdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_buffer_make(size : Int) -> TimeseriesdecompvmdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdBuffer::len(self : TimeseriesdecompvmdBuffer) -> Int { self.size }

pub fn TimeseriesdecompvmdBuffer::get(self : TimeseriesdecompvmdBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdBuffer::set(self : TimeseriesdecompvmdBuffer, i : Int, v : Double) -> TimeseriesdecompvmdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdBuffer::sum(self : TimeseriesdecompvmdBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdBuffer::mean(self : TimeseriesdecompvmdBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdBuffer::scale(self : TimeseriesdecompvmdBuffer, f : Double) -> TimeseriesdecompvmdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdBuffer::add(self : TimeseriesdecompvmdBuffer, other : TimeseriesdecompvmdBuffer) -> TimeseriesdecompvmdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdBuffer::copy(self : TimeseriesdecompvmdBuffer) -> TimeseriesdecompvmdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdBuffer::fill(self : TimeseriesdecompvmdBuffer, v : Double) -> TimeseriesdecompvmdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdBuffer::min(self : TimeseriesdecompvmdBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdBuffer::max(self : TimeseriesdecompvmdBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdBuffer::to_string(self : TimeseriesdecompvmdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_cursor_make(size : Int) -> TimeseriesdecompvmdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdCursor::len(self : TimeseriesdecompvmdCursor) -> Int { self.size }

pub fn TimeseriesdecompvmdCursor::get(self : TimeseriesdecompvmdCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdCursor::set(self : TimeseriesdecompvmdCursor, i : Int, v : Double) -> TimeseriesdecompvmdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdCursor::sum(self : TimeseriesdecompvmdCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdCursor::mean(self : TimeseriesdecompvmdCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdCursor::scale(self : TimeseriesdecompvmdCursor, f : Double) -> TimeseriesdecompvmdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdCursor::add(self : TimeseriesdecompvmdCursor, other : TimeseriesdecompvmdCursor) -> TimeseriesdecompvmdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdCursor::copy(self : TimeseriesdecompvmdCursor) -> TimeseriesdecompvmdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdCursor::fill(self : TimeseriesdecompvmdCursor, v : Double) -> TimeseriesdecompvmdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdCursor::min(self : TimeseriesdecompvmdCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdCursor::max(self : TimeseriesdecompvmdCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdCursor::to_string(self : TimeseriesdecompvmdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_view_make(size : Int) -> TimeseriesdecompvmdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdView::len(self : TimeseriesdecompvmdView) -> Int { self.size }

pub fn TimeseriesdecompvmdView::get(self : TimeseriesdecompvmdView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdView::set(self : TimeseriesdecompvmdView, i : Int, v : Double) -> TimeseriesdecompvmdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdView::sum(self : TimeseriesdecompvmdView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdView::mean(self : TimeseriesdecompvmdView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdView::scale(self : TimeseriesdecompvmdView, f : Double) -> TimeseriesdecompvmdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdView::add(self : TimeseriesdecompvmdView, other : TimeseriesdecompvmdView) -> TimeseriesdecompvmdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdView::copy(self : TimeseriesdecompvmdView) -> TimeseriesdecompvmdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdView::fill(self : TimeseriesdecompvmdView, v : Double) -> TimeseriesdecompvmdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdView::min(self : TimeseriesdecompvmdView) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdView::max(self : TimeseriesdecompvmdView) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdView::to_string(self : TimeseriesdecompvmdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_range_make(size : Int) -> TimeseriesdecompvmdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdRange::len(self : TimeseriesdecompvmdRange) -> Int { self.size }

pub fn TimeseriesdecompvmdRange::get(self : TimeseriesdecompvmdRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdRange::set(self : TimeseriesdecompvmdRange, i : Int, v : Double) -> TimeseriesdecompvmdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdRange::sum(self : TimeseriesdecompvmdRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdRange::mean(self : TimeseriesdecompvmdRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdRange::scale(self : TimeseriesdecompvmdRange, f : Double) -> TimeseriesdecompvmdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdRange::add(self : TimeseriesdecompvmdRange, other : TimeseriesdecompvmdRange) -> TimeseriesdecompvmdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdRange::copy(self : TimeseriesdecompvmdRange) -> TimeseriesdecompvmdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdRange::fill(self : TimeseriesdecompvmdRange, v : Double) -> TimeseriesdecompvmdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdRange::min(self : TimeseriesdecompvmdRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdRange::max(self : TimeseriesdecompvmdRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdRange::to_string(self : TimeseriesdecompvmdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_slice_make(size : Int) -> TimeseriesdecompvmdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompvmdSlice::len(self : TimeseriesdecompvmdSlice) -> Int { self.size }

pub fn TimeseriesdecompvmdSlice::get(self : TimeseriesdecompvmdSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompvmdSlice::set(self : TimeseriesdecompvmdSlice, i : Int, v : Double) -> TimeseriesdecompvmdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdSlice::sum(self : TimeseriesdecompvmdSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompvmdSlice::mean(self : TimeseriesdecompvmdSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompvmdSlice::scale(self : TimeseriesdecompvmdSlice, f : Double) -> TimeseriesdecompvmdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdSlice::add(self : TimeseriesdecompvmdSlice, other : TimeseriesdecompvmdSlice) -> TimeseriesdecompvmdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompvmdSlice::copy(self : TimeseriesdecompvmdSlice) -> TimeseriesdecompvmdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdSlice::fill(self : TimeseriesdecompvmdSlice, v : Double) -> TimeseriesdecompvmdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompvmdSlice::min(self : TimeseriesdecompvmdSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompvmdSlice::max(self : TimeseriesdecompvmdSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompvmdSlice::to_string(self : TimeseriesdecompvmdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

